import importlib
import pkgutil
import os
import shutil
import datetime
import threading
import sys
import subprocess
import json
import logging
from PySide6.QtCore import QObject, Signal, Slot

from sqlalchemy import Column, String, Boolean, Integer, DateTime, create_engine
from sqlalchemy.orm import sessionmaker, declarative_base, Session
from sqlalchemy.exc import SQLAlchemyError

import psutil
import time # Importation de la librairie time

# Configuration du logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

Base = declarative_base()

class PluginState(Base):
    __tablename__ = 'plugin_states'
    name = Column(String, primary_key=True)
    enabled = Column(Boolean, default=False)
    last_run = Column(DateTime, nullable=True)
    pid = Column(Integer, nullable=True)
    run_dependencies = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)

class PluginStateManager:
    def __init__(self, db_session):
        self.db: Session = db_session

    def get_all_states(self):
        try:
            return {p.name: {
                "enabled": p.enabled,
                "last_run": p.last_run.isoformat() if p.last_run else None,
                "pid": p.pid,
                "run_dependencies": p.run_dependencies
            } for p in self.db.query(PluginState).all()}
        except SQLAlchemyError as e:
            logging.error(f"Erreur lors de la récupération des états des plugins : {e}")
            return {}

    def update_state(self, name, updates: dict):
        try:
            plugin = self.db.query(PluginState).filter_by(name=name).first()
            if not plugin:
                plugin = PluginState(name=name)
                self.db.add(plugin)

            for key, value in updates.items():
                setattr(plugin, key, value)
            self.db.commit()
        except SQLAlchemyError as e:
            logging.error(f"Erreur lors de la mise à jour de l'état du plugin '{name}': {e}")
            self.db.rollback()

    def remove_missing_plugins(self, current_plugins):
        try:
            all_plugins = self.db.query(PluginState).all()
            removed = False
            for plugin in all_plugins:
                if plugin.name not in current_plugins:
                    self.db.delete(plugin)
                    removed = True
            if removed:
                self.db.commit()
        except SQLAlchemyError as e:
            logging.error(f"Erreur lors de la suppression des plugins manquants : {e}")
            self.db.rollback()

class PluginRunner(threading.Thread):
    def __init__(self, plugin_path, plugin_name):
        super().__init__()
        self.plugin_path = plugin_path
        self.plugin_name = plugin_name
        self.process = None
        self._stop_event = threading.Event()
        self.daemon = True

    def run(self):
        try:
            logging.info(f"Démarrage du plugin '{self.plugin_name}' dans un subprocessus: {self.plugin_path}")
            self.process = subprocess.Popen([sys.executable, self.plugin_path])
            logging.info(f"Subprocessus démarré pour '{self.plugin_name}' avec le PID: {self.process.pid if self.process else None}") # Log ajouté pour le PID
            self.process.wait()
            logging.info(f"Le plugin '{self.plugin_name}' s'est terminé avec le code de sortie: {self.process.returncode}")
        except Exception as e:
            logging.error(f"Erreur lors du lancement du plugin '{self.plugin_name}' dans un subprocessus : {e}")

    def stop(self):
        if self.process:
            logging.info(f"Arrêt demandé pour le plugin '{self.plugin_name}' (PID: {self.process.pid if self.process else None})") # PID dans le log d'arrêt
            self.process.terminate()
            try:
                self.process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                logging.warning(f"Le plugin '{self.plugin_name}' (PID: {self.process.pid if self.process else None}) n'a pas répondu à la terminaison, envoi d'un signal kill.") # PID dans le log de timeout
                self.process.kill()
            self.process = None
        self._stop_event.set()

class Managers(QObject):
    Plugin_manager_signal = Signal(str)
    MAX_PLUGIN_PROCESSES = 5

    def __init__(self, plugins_path: str = "plugins", db_url: str = "sqlite:///./plugins/data/.state.plugins.db") -> None:
        super().__init__()
        self.plugins_path = plugins_path
        self.plugin_threads = {}

        engine = create_engine(db_url)
        Base.metadata.create_all(engine)
        SessionLocal = sessionmaker(bind=engine)
        self.db = SessionLocal()
        self.state_manager = PluginStateManager(self.db)

    def initialize_plugin_state(self):
        states = self.state_manager.get_all_states()
        for _, name, _ in pkgutil.iter_modules([self.plugins_path]):
            if name not in states:
                self.state_manager.update_state(name, {
                    "enabled": False,
                    "last_run": None,
                    "pid": None,
                    "run_dependencies": True
                })

    def validate_plugin(self, module):
        required_keys = ["name", "version", "author"]
        if not hasattr(module, 'PLUGIN_INFO') or not all(k in module.PLUGIN_INFO for k in required_keys):
            logging.warning(f"Le plugin '{os.path.basename(os.path.dirname(module.__file__))}' ne contient pas les informations requises dans PLUGIN_INFO.")
            return False
        if not hasattr(module, 'Plugin'):
            logging.warning(f"Le plugin '{os.path.basename(os.path.dirname(module.__file__))}' ne contient pas de classe Plugin.")
            return False
        plugin_class = getattr(module, 'Plugin')
        return callable(getattr(plugin_class, 'run', None)) and callable(getattr(plugin_class, 'stop', None))

    def load_plugins(self):
        plugins = []
        plugin_state = self.state_manager.get_all_states()

        if not os.path.exists(self.plugins_path):
            logging.error("Répertoire plugins introuvable.")
            return plugins

        for _, name, _ in pkgutil.iter_modules([self.plugins_path]):
            full_module_name = f"{self.plugins_path}.{name}.runner"
            state = plugin_state.get(name, {"enabled": False})
            if state.get("enabled") in [True, False]:
                try:
                    module = importlib.import_module(full_module_name)
                    if self.validate_plugin(module):
                        plugins.append((module, state.get("enabled", False)))
                        self.Plugin_manager_signal.emit(f"Plugin {name} chargé.")
                except ImportError as e:
                    logging.error(f"Erreur lors de l'importation du plugin '{name}': {e}")
                    self.state_manager.update_state(name, {"enabled": False}) # Désactiver le plugin en cas d'erreur d'importation
                except Exception as e:
                    logging.error(f"Erreur inattendue lors du chargement du plugin '{name}': {e}")
                    self.state_manager.update_state(name, {"enabled": False}) # Désactiver le plugin en cas d'erreur inattendue
        return plugins

    def unload_plugin_module(self, plugin_name):
        full_module_name = f"{self.plugins_path}.{plugin_name}.runner"
        if full_module_name in sys.modules:
            del sys.modules[full_module_name]
            logging.info(f"Module '{full_module_name}' déchargé.")
            return True
        else:
            logging.warning(f"Le module '{full_module_name}' n'est pas chargé.")
            return False

    @Slot(str, bool)
    def set_plugin_state(self, plugin_name: str, state: bool):
        if not os.path.exists(os.path.join(self.plugins_path, plugin_name)):
            print(f"Erreur: Le plugin '{plugin_name}' n'existe pas.")
            return
        self.state_manager.update_state(plugin_name, {"enabled": state})
        self.Plugin_manager_signal.emit(f"État de {plugin_name} : {'actif' if state else 'inactif'}")

    def cleanup_plugin_states(self):
        current_plugins = {name for _, name, _ in pkgutil.iter_modules([self.plugins_path])}
        self.state_manager.remove_missing_plugins(current_plugins)

    def install_plugin_dependencies(self, plugin_dir):
        requirements_path = os.path.join(plugin_dir, "requirements.txt")
        if os.path.exists(requirements_path):
            try:
                logging.info(f"Installation des dépendances pour le plugin dans '{plugin_dir}'...")
                subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", requirements_path])
                logging.info(f"Dépendances installées pour le plugin dans '{plugin_dir}'.")
            except subprocess.CalledProcessError as e:
                logging.error(f"Erreur d'installation des dépendances pour '{plugin_dir}': {e}")
            except FileNotFoundError:
                logging.error(f"Erreur: pip n'a pas été trouvé. Assurez-vous qu'il est installé et dans votre PATH.")

    def get_plugin_info(self, plugin_name):
        plugin_path = os.path.join(self.plugins_path, plugin_name, "runner.py")
        if os.path.exists(plugin_path):
            try:
                spec = importlib.util.spec_from_file_location(f"{self.plugins_path}.{plugin_name}.runner", plugin_path)
                module = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(module)
                if hasattr(module, 'PLUGIN_INFO'):
                    return module.PLUGIN_INFO
                else:
                    logging.warning(f"Le plugin '{plugin_name}' n'a pas de variable PLUGIN_INFO.")
                    return {}
            except ImportError:
                logging.error(f"Erreur lors de l'importation des informations du plugin '{plugin_name}'.")
                return {}
            except Exception as e:
                logging.error(f"Erreur inattendue lors de la récupération des informations du plugin '{plugin_name}': {e}")
                return {}
        else:
            logging.error(f"Le fichier runner.py du plugin '{plugin_name}' est introuvable.")
            return {}

    def get_plugin_resources(self, plugin_name):
        plugin_state = self.state_manager.get_all_states().get(plugin_name)
        if plugin_state and plugin_state.get("pid"):
            pid = plugin_state["pid"]
            time.sleep(0.1) # Ajouter un court délai de 100 millisecondes
            try:
                process = psutil.Process(pid)
                cpu_percent = process.cpu_percent(interval=0.1)  # Pourcentage d'utilisation du CPU
                memory_info = process.memory_info().rss / (1024 * 1024)  # Mémoire résidente en MB
                open_files = len(process.open_files())
                connections = len(process.connections())
                return {
                    "cpu_percent": f"{cpu_percent:.2f}%",
                    "memory_rss_mb": f"{memory_info:.2f} MB",
                    "open_files": open_files,
                    "network_connections": connections
                }

            except psutil.NoSuchProcess:
                return {"error": f"Processus pour le plugin '{plugin_name}' (PID {pid}) n'existe plus."}
            except psutil.AccessDenied:
                return {"error": f"Permission refusée pour accéder aux informations du processus (PID {pid})."}
            except Exception as e:
                return {"error": f"Erreur lors de la récupération des ressources du plugin '{plugin_name}': {e}"}
        else:
            return {"info": f"Le plugin '{plugin_name}' n'est pas en cours d'exécution."}

    def reload_plugin(self, plugin_name):
        if plugin_name not in self.plugin_threads:
            print(f"Le plugin '{plugin_name}' n'est pas actif.")
            return

        print(f"Rechargement du plugin '{plugin_name}'...")
        # 1. Arrêter le plugin
        self.plugin_threads[plugin_name].stop()
        del self.plugin_threads[plugin_name]
        self.state_manager.update_state(plugin_name, {"pid": None, "last_run": None})

        # 2. Décharger le module
        if self.unload_plugin_module(plugin_name):
            # 3. Réimporter et redémarrer le plugin
            plugin_path = os.path.abspath(os.path.join(self.plugins_path, plugin_name, "runner.py"))
            plugin_runner = PluginRunner(plugin_path, plugin_name)
            self.plugin_threads[plugin_name] = plugin_runner
            self.plugin_threads[plugin_name].start()
            pid = plugin_runner.process.pid if plugin_runner.process else None
            self.state_manager.update_state(plugin_name, {"pid": pid, "last_run": datetime.datetime.now()})
            print(f"Le plugin '{plugin_name}' a été rechargé.")
        else:
            print(f"Erreur lors du déchargement du module '{plugin_name}'. Le rechargement a échoué.")

    def run_plugins(self):
        self.initialize_plugin_state()
        self.cleanup_plugin_states()
        plugins = self.load_plugins()
        plugin_state = self.state_manager.get_all_states()
        active_plugin_count = len(self.plugin_threads)

        for module, enabled in plugins:
            plugin_name = os.path.basename(os.path.dirname(module.__file__))
            plugin_path = os.path.abspath(os.path.join(self.plugins_path, plugin_name, "runner.py"))
            plugin_dir = os.path.join(self.plugins_path, plugin_name)
            plug_conf = plugin_state.get(plugin_name, {})

            if enabled:
                if plugin_name not in self.plugin_threads and active_plugin_count < self.MAX_PLUGIN_PROCESSES:
                    if plug_conf.get("run_dependencies", False):
                        self.install_plugin_dependencies(plugin_dir)
                        self.state_manager.update_state(plugin_name, {"run_dependencies": False})

                    plugin_runner = PluginRunner(plugin_path, plugin_name)
                    self.plugin_threads[plugin_name] = plugin_runner
                    plugin_runner.start()
                    pid = plugin_runner.process.pid if plugin_runner.process else None
                    self.state_manager.update_state(plugin_name, {
                        "pid": pid,
                        "last_run": datetime.datetime.now()
                    })
                    active_plugin_count += 1
                elif plugin_name not in self.plugin_threads:
                    logging.warning(f"Limite de processus atteinte pour '{plugin_name}'.")
            else:
                if plugin_name in self.plugin_threads:
                    self.plugin_threads[plugin_name].stop()
                    del self.plugin_threads[plugin_name]
                    self.state_manager.update_state(plugin_name, {"pid": None})

        # Nettoyer les threads terminés
        self.plugin_threads = {name: thread for name, thread in self.plugin_threads.items() if thread.is_alive()}

    def run_always(self):
        print("--- Gestionnaire de plugins démarré ---")
        self._run_always_loop()

    def _run_always_loop(self):
        print("Tapez 'help' pour voir les commandes disponibles.\n")

        while True:
            try:
                cmd = input("plugin > ").strip().split()
                if not cmd:
                    continue

                action = cmd[0].lower()

                if action == "help":
                    print("""
                                        Commandes disponibles :
                            list                    : Affiche tous les plugins etleur état
                            run <plugin>              : Active le plugin spécifié
                            stop <plugin>             : Désactive le plugin spécifié
                            status <plugin>           : Affiche les détails d’un plugin
                            info <plugin>             : Affiche les informations détaillées d’un plugin
                            reload <plugin>           : Recharge un plugin actif
                            resources <plugin>        : Affiche l’utilisation des ressources d’un plugin actif
                            remove <plugin>           : Supprime un plugin désactivé de la base
                            help                    : Affiche cette aide
                            exit                    : Quitte le gestionnaire
                        """)
                elif action == "list":
                    plugin_state = self.state_manager.get_all_states()
                    plugins = pkgutil.iter_modules([self.plugins_path])
                    print(f"{'Plugin':20} | {'Actif':^6} | {'PID':^6} | Dernier lancement")
                    print("-" * 60)
                    for _, name, _ in plugins:
                        state = plugin_state.get(name, {})
                        actif = "Oui" if state.get("enabled", False) else "Non"
                        pid = state.get("pid", "----")
                        last_run = state.get("last_run", "----")
                        print(f"{name:20} | {actif:^6} | {str(pid):^6} | {last_run}")
                elif action == "run" and len(cmd) == 2:
                    plugin_name = cmd[1]
                    if not os.path.exists(os.path.join(self.plugins_path, plugin_name)):
                        print(f"Erreur: Le plugin '{plugin_name}' n'existe pas.")
                    else:
                        self.set_plugin_state(plugin_name, True)
                        self.run_plugins()
                elif action == "stop" and len(cmd) == 2:
                    plugin_name = cmd[1]
                    if not os.path.exists(os.path.join(self.plugins_path, plugin_name)):
                        print(f"Erreur: Le plugin '{plugin_name}' n'existe pas.")
                    else:
                        self.set_plugin_state(plugin_name, False)
                        self.run_plugins()
                elif action == "status" and len(cmd) == 2:
                    plugin_name = cmd[1]
                    plugin_state = self.state_manager.get_all_states()
                    info = plugin_state.get(plugin_name)
                    if not info:
                        print(f"Plugin '{plugin_name}' introuvable.")
                    else:
                        print(json.dumps(info, indent=4, default=str))
                elif action == "info" and len(cmd) == 2:
                    plugin_name = cmd[1]
                    plugin_info = self.get_plugin_info(plugin_name)
                    if plugin_info:
                        print(f"\nInformations détaillées pour le plugin '{plugin_name}':")
                        print(json.dumps(plugin_info, indent=4, default=str))
                        plugin_state = self.state_manager.get_all_states().get(plugin_name, {})
                        print("\nÉtat actuel :")
                        print(json.dumps(plugin_state, indent=4, default=str))
                    else:
                        print(f"Informations introuvables pour le plugin '{plugin_name}'.")
                elif action == "reload" and len(cmd) == 2:
                    plugin_name = cmd[1]
                    if not os.path.exists(os.path.join(self.plugins_path, plugin_name)):
                        print(f"Erreur: Le plugin '{plugin_name}' n'existe pas.")
                    else:
                        self.reload_plugin(plugin_name)
                elif action == "resources" and len(cmd) == 2:
                    plugin_name = cmd[1]
                    resources = self.get_plugin_resources(plugin_name)
                    print(f"\nRessources utilisées par le plugin '{plugin_name}':")
                    print(json.dumps(resources, indent=4))
                elif action == "remove" and len(cmd) == 2:
                    plugin_name = cmd[1]
                    plugin_info = self.db.query(PluginState).filter_by(name=plugin_name).first()
                    if not plugin_info:
                        print(f"Plugin '{plugin_name}' introuvable dans la base de données.")
                    elif plugin_info.enabled:
                        print("Impossible de supprimer un plugin actif. Veuillez le désactiver d'abord.")
                    else:
                        try:
                            self.db.delete(plugin_info)
                            self.db.commit()
                            print(f"Plugin '{plugin_name}' supprimé de la base de données.")
                        except SQLAlchemyError as e:
                            logging.error(f"Erreur lors de la suppression du plugin '{plugin_name}': {e}")
                            self.db.rollback()
                elif action == "exit":
                    print("Arrêt demandé.")
                    break
                else:
                    print("Commande inconnue. Tapez 'help'.")
            except KeyboardInterrupt:
                print("\nArrêt manuel.")
                break
            finally:
                if hasattr(self, 'db'):
                    self.db.close()

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Gestionnaire de plugins.")
    parser.add_argument("--list", action="store_true", help="Liste tous les plugins et leur état.")
    parser.add_argument("--run", metavar="PLUGIN", type=str, help="Active un plugin spécifique.")
    parser.add_argument("--stop", metavar="PLUGIN", type=str, help="Désactive un plugin spécifique.")
    parser.add_argument("--status", metavar="PLUGIN", type=str, help="Affiche le statut d’un plugin.")
    parser.add_argument("--info", metavar="PLUGIN", type=str, help="Affiche les informations détaillées d’un plugin.")
    parser.add_argument("--reload", metavar="PLUGIN", type=str, help="Recharge un plugin actif.")
    parser.add_argument("--resources", metavar="PLUGIN", type=str, help="Affiche l’utilisation des ressources d’un plugin actif.")
    parser.add_argument("--remove", metavar="PLUGIN", type=str, help="Supprime un plugin désactivé.")
    parser.add_argument("--exit", action="store_true", help="Quitte le gestionnaire de plugins.")

    args = parser.parse_args()

    manager = Managers()

    if args.list:
        manager.run_plugins()  # charge les plugins
        plugin_state = manager.state_manager.get_all_states()
        plugins = pkgutil.iter_modules([manager.plugins_path])
        print(f"{'Plugin':20} | {'Actif':^6} | {'PID':^6} | Dernier lancement")
        print("-" * 60)
        for _, name, _ in plugins:
            state = plugin_state.get(name, {})
            actif = "Oui" if state.get("enabled", False) else "Non"
            pid = state.get("pid", "----")
            last_run = state.get("last_run", "----")
            print(f"{name:20} | {actif:^6} | {str(pid):^6} | {last_run}")

    elif args.run:
        plugin_name = args.run
        if not os.path.exists(os.path.join(manager.plugins_path, plugin_name)):
            print(f"Erreur: Le plugin '{plugin_name}' n'existe pas.")
        else:
            manager.set_plugin_state(plugin_name, True)
            manager.run_plugins()

    elif args.stop:
        plugin_name = args.stop
        if not os.path.exists(os.path.join(manager.plugins_path, plugin_name)):
            print(f"Erreur: Le plugin '{plugin_name}' n'existe pas.")
        else:
            manager.set_plugin_state(plugin_name, False)
            manager.run_plugins()

    elif args.status:
        plugin_name = args.status
        plugin_state = manager.state_manager.get_all_states()
        info = plugin_state.get(plugin_name)
        if not info:
            print(f"Plugin '{plugin_name}' introuvable.")
        else:
            print(json.dumps(info, indent=4, default=str))

    elif args.info:
        plugin_name = args.info
        plugin_info = manager.get_plugin_info(plugin_name)
        if plugin_info:
            print(f"\nInformations détaillées pour le plugin '{plugin_name}':")
            print(json.dumps(plugin_info, indent=4, default=str))
            plugin_state = manager.state_manager.get_all_states().get(plugin_name, {})
            print("\nÉtat actuel :")
            print(json.dumps(plugin_state, indent=4, default=str))
        else:
            print(f"Informations introuvables pour le plugin '{plugin_name}'.")

    elif args.reload:
        plugin_name = args.reload
        if not os.path.exists(os.path.join(manager.plugins_path, plugin_name)):
            print(f"Erreur: Le plugin '{plugin_name}' n'existe pas.")
        else:
            manager.reload_plugin(plugin_name)

    elif args.resources:
        plugin_name = args.resources
        resources = manager.get_plugin_resources(plugin_name)
        print(f"\nRessources utilisées par le plugin '{plugin_name}':")
        print(json.dumps(resources, indent=4))

    elif args.remove:
        plugin_name = args.remove
        plugin_info = manager.db.query(PluginState).filter_by(name=plugin_name).first()
        if not plugin_info:
            print(f"Plugin '{plugin_name}' introuvable dans la base de données.")
        elif plugin_info.enabled:
            print("Impossible de supprimer un plugin actif. Veuillez le désactiver d'abord.")
        else:
            try:
                manager.db.delete(plugin_info)
                manager.db.commit()
                print(f"Plugin '{plugin_name}' supprimé de la base de données.")
            except SQLAlchemyError as e:
                logging.error(f"Erreur lors de la suppression du plugin '{plugin_name}': {e}")
                manager.db.rollback()

    elif args.exit:
        print("Arrêt demandé.")

    else:
        # Si aucune commande CLI n'est spécifiée, passer au mode interactif.
        manager.run_always()
