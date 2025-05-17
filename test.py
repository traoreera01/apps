import sys
import uuid
from datetime import datetime
from PySide6.QtCore import QObject, Slot, Property, Signal, QUrl, QDateTime
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

class EventModel(QObject):
    """Modèle pour gérer les événements du calendrier"""
    eventsChanged = Signal()
    
    def __init__(self):
        super().__init__()
        # Liste des événements (chaque événement est un dictionnaire)
        self._events = []
        # Ajouter quelques événements de test
        self.addSampleEvents()

    @Property(list, notify=eventsChanged)
    def events(self):
        """Getter pour la liste des événements"""
        return self._events

    @Slot(str, 'QVariant', 'QVariant', str, result=str)
    def addEvent(self, title, start, end, description=""):
        """Ajouter un nouvel événement"""
        event_id = str(uuid.uuid4())
        
        # Vérifier si start et end sont des objets Date JavaScript
        # Dans ce cas, nous devons les convertir en format ISO
        if isinstance(start, dict) and 'jsDate' in start:
            start_date = datetime.fromtimestamp(start['jsDate'] / 1000).isoformat()
        else:
            # Essayons de convertir directement pour QDateTime
            try:
                start_date = start.toString("yyyy-MM-ddThh:mm:ss")
            except:
                # Fallback pour les valeurs JavaScript
                start_date = str(start)
                
        if isinstance(end, dict) and 'jsDate' in end:
            end_date = datetime.fromtimestamp(end['jsDate'] / 1000).isoformat()
        else:
            try:
                end_date = end.toString("yyyy-MM-ddThh:mm:ss")
            except:
                end_date = str(end)
        
        # Couleur aléatoire simple
        colors = ["#4285F4", "#EA4335", "#FBBC05", "#34A853", "#FF6D01", "#46BDC6"]
        import random
        color = random.choice(colors)
        
        event = {
            "id": event_id,
            "title": title,
            "start": start_date,
            "end": end_date,
            "description": description,
            "color": color
        }
        
        self._events.append(event)
        self.eventsChanged.emit()
        return event_id

    @Slot(str, str, 'QVariant', 'QVariant', str)
    def updateEvent(self, event_id, title, start, end, description=""):
        """Mettre à jour un événement existant"""
        for i in range(len(self._events)):
            if self._events[i]["id"] == event_id:
                # Convertir QDateTime en format compatible JSON ou gérer les dates JavaScript
                if isinstance(start, dict) and 'jsDate' in start:
                    start_date = datetime.fromtimestamp(start['jsDate'] / 1000).isoformat()
                else:
                    try:
                        start_date = start.toString("yyyy-MM-ddThh:mm:ss")
                    except:
                        start_date = str(start)
                        
                if isinstance(end, dict) and 'jsDate' in end:
                    end_date = datetime.fromtimestamp(end['jsDate'] / 1000).isoformat()
                else:
                    try:
                        end_date = end.toString("yyyy-MM-ddThh:mm:ss")
                    except:
                        end_date = str(end)
                
                self._events[i]["title"] = title
                self._events[i]["start"] = start_date
                self._events[i]["end"] = end_date
                self._events[i]["description"] = description
                self.eventsChanged.emit()
                break

    @Slot(str)
    def deleteEvent(self, event_id):
        """Supprimer un événement"""
        self._events = [event for event in self._events if event["id"] != event_id]
        self.eventsChanged.emit()

    @Slot(str, result='QVariant')
    def getEvent(self, event_id):
        """Récupérer un événement par son ID"""
        for event in self._events:
            if event["id"] == event_id:
                return event
        return None

    def addSampleEvents(self):
        """Ajouter des événements de test"""
        # Aujourd'hui
        today = datetime.now()
        year = today.year
        month = today.month - 1  # En JavaScript, les mois commencent à 0
        day = today.day
        
        # Exemple 1: Réunion d'équipe aujourd'hui
        start_date = f"{year}-{month+1:02d}-{day:02d}T10:00:00"
        end_date = f"{year}-{month+1:02d}-{day:02d}T11:00:00"
        self.addEvent("Réunion d'équipe", start_date, end_date, "Discussion hebdomadaire")
        
        # Exemple 2: Déjeuner professionnel
        start_date = f"{year}-{month+1:02d}-{day:02d}T12:00:00"
        end_date = f"{year}-{month+1:02d}-{day:02d}T13:00:00"
        self.addEvent("Déjeuner professionnel", start_date, end_date, "Restaurant Le Central")
        
        # Exemple 3: Événement demain
        if day < 28:
            tomorrow = day + 1
            start_date = f"{year}-{month+1:02d}-{tomorrow:02d}T14:00:00"
            end_date = f"{year}-{month+1:02d}-{tomorrow:02d}T16:00:00"
            self.addEvent("Présentation client", start_date, end_date, "Préparer les slides")




def main():
    # Créer l'application Qt
    app = QGuiApplication(sys.argv)
    
    # Créer le moteur QML
    engine = QQmlApplicationEngine()
    
    # Instancier notre modèle d'événements
    event_model = EventModel()
    
    # Exposer le modèle au contexte QML
    engine.rootContext().setContextProperty("eventModel", event_model)
    
    # Charger le fichier QML principal
    qml_file = "main.qml"  # Assurez-vous que ce fichier existe
    engine.load(QUrl.fromLocalFile(qml_file))
    
    if not engine.rootObjects():
        sys.exit(-1)
        
    # Exécuter l'application
    sys.exit(app.exec())


if __name__ == "__main__":
    main()