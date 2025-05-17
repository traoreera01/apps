import time
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

PLUGIN_INFO = {
    "name": "ToDo",
    "version": "0.1.0",
    "author": "Votre Nom"
}

class Plugin:
    def __init__(self):
        self._running = False

    def run(self):
        self._running = True
        logging.info("Plugin ToDo démarré.")
        while self._running:
            logging.info("Le plugin ToDo fait quelque chose...")
            time.sleep(5) # Simule une activité
        logging.info("Plugin ToDo arrêté.")

    def stop(self):
        self._running = False

if __name__ == "__main__":
    plugin = Plugin()
    plugin.run()