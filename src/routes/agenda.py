from PySide6.QtCore import QObject, Signal, Slot, Property, QDate, QDateTime, QUrl, QTime
from property import InsertProperty, Wintools
from PySide6.QtWidgets import QApplication




class EventModel(QObject):
    eventsChanged = Signal()
    
    def __init__(self):
        super().__init__()
        self._events = []  # Liste d'événements
        
        # Ajouter quelques événements de test
        # Correction: QDateTime a besoin d'un QDate et un QTime séparés
        self.addEvent("Réunion d'équipe", 
                      QDateTime(QDate(2025, 5, 3), QTime(10, 0)), 
                      QDateTime(QDate(2025, 5, 3), QTime(11, 30)),
                      "Discussion sur le nouveau projet")
        
        self.addEvent("Déjeuner avec client", 
                      QDateTime(QDate(2025, 5, 5), QTime(12, 30)), 
                      QDateTime(QDate(2025, 5, 5), QTime(14, 0)),
                      "Restaurant Le Café")
    
    @Property('QVariantList', notify=eventsChanged)
    def events(self):
        return self._events
    
    @Slot(str, 'QDateTime', 'QDateTime', str)
    def addEvent(self, title, start, end, description=""):
        self._events.append({
            "id": len(self._events),
            "title": title,
            "start": start,
            "end": end,
            "description": description,
            "color": "#4285F4"  # Couleur Google Agenda par défaut
        })
        self.eventsChanged.emit()
    
    @Slot(int)
    def removeEvent(self, event_id):
        self._events = [e for e in self._events if e["id"] != event_id]
        self.eventsChanged.emit()
    
    @Slot(int, str, 'QDateTime', 'QDateTime', str)
    def updateEvent(self, event_id, title, start, end, description):
        for event in self._events:
            if event["id"] == event_id:
                event["title"] = title
                event["start"] = start
                event["end"] = end
                event["description"] = description
                self.events