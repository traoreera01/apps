import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: mainWindow
    visible: true
    width: 800
    height: 600
    title: "Calendrier"
    
    // Propriétés pour suivre la date actuelle
    property var currentDate: new Date()
    property int currentYear: currentDate.getFullYear()
    property int currentMonth: currentDate.getMonth()
    property int currentDay: currentDate.getDate()
    // Noms des mois et jours
    property var monthNames: ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
    property var dayNames: ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam"]
    
    // Propriété pour suivre la vue actuelle (mois, semaine, jour)
    property string currentView: "month"
    
    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"
        
        Rectangle {
            id: header
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            height: 50
            color: "transparent"
            
            RowLayout {
                anchors.fill: parent
                
                ToolButton {
                    text: "Aujourd'hui"
                    onClicked: {
                        mainWindow.currentDate = new Date()
                        mainWindow.currentYear = mainWindow.currentDate.getFullYear()
                        mainWindow.currentMonth = mainWindow.currentDate.getMonth()
                        mainWindow.currentDay = mainWindow.currentDate.getDate()
                        updateCalendar()
                    }
                }
                
                ToolButton {
                    text: "<"
                    onClicked: navigatePrevious()
                }
                
                ToolButton {
                    text: ">"
                    onClicked: navigateNext()
                }
                
                Label {
                    id: dateLabel
                    text: mainWindow.monthNames[mainWindow.currentMonth] + " " + mainWindow.currentYear
                    font.bold: true
                    font.pixelSize: 18
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }
                
                ComboBox {
                    id: viewSelector
                    model: ["Mois", "Semaine", "Jour"]
                    currentIndex: 0
                    onCurrentIndexChanged: {
                        switch(currentIndex) {
                            case 0: mainWindow.currentView = "month"; break;
                            case 1: mainWindow.currentView = "week"; break;
                            case 2: mainWindow.currentView = "day"; break;
                        }
                        updateCalendar()
                    }
                }
                
                ToolButton {
                    text: "+"
                    onClicked: {
                        // Réinitialiser le dialogue pour un nouvel événement
                        editEventDialog.isNewEvent = true;
                        editEventDialog.eventId = null;
                        editEventDialog.title = "Créer un événement";
                        
                        // Préremplir avec la date actuelle
                        var dateStr = mainWindow.currentYear + "-" + (mainWindow.currentMonth + 1).toString().padStart(2, "0") + "-" + mainWindow.currentDay.toString().padStart(2, "0");
                        editEventDialog.eventTitle.text = "";
                        editEventDialog.startDate.text = dateStr;
                        editEventDialog.startTime.text = "09:00";
                        editEventDialog.endDate.text = dateStr;
                        editEventDialog.endTime.text = "10:00";
                        editEventDialog.eventDescription.text = "";
                        
                        editEventDialog.open();
                    }
                }
            }
        }
        
        Rectangle {
            id: calendar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 0
            anchors.bottomMargin: 10
            clip: true
            color: "#83271d1d"
            radius: 10
            
            StackLayout {
                anchors.fill: parent
                anchors.margins: 20
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                currentIndex: viewSelector.currentIndex
                
                Item {
                    id: monthView
                    
                    GridLayout {
                        anchors.fill: parent
                        columns: 7
                        rows: 7
                        
                        // En-têtes des jours de la semaine
                        Repeater {
                            model: 7
                            Rectangle {
                                Layout.row: 0
                                Layout.column: index
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                radius: 10
                                color: '#fff'
                                Label {
                                    anchors.centerIn: parent
                                    text: mainWindow.dayNames[index]
                                    font.bold: true
                                }
                            }
                        }
                        
                        // Jours du mois
                        Repeater {
                            id: daysRepeater
                            model: 42 // 6 semaines max (6 * 7 = 42)
                            
                            Rectangle {
                                id: dayRect
                                property date cellDate
                                property bool isCurrentMonth: false
                                property bool isToday: false
                                radius: 10
                                Layout.row: Math.floor(index / 7) + 1
                                Layout.column: index % 7
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                
                                color: isToday ? "#e8f0fe" : "white"
                                border.width: 1
                                border.color: "#e0e0e0"
                                
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 3
                                    spacing: 2
                                    
                                    Label {
                                        id: dayNumber
                                        text: ""
                                        font.bold: isToday
                                        color: isCurrentMonth ? "black" : "#9e9e9e"
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    }
                                    
                                    // Liste des événements du jour
                                    ListView {
                                        id: eventsList
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        clip: true
                                        spacing: 2
                                        model: []
                                        
                                        delegate: Rectangle {
                                            width: eventsList.width
                                            height: 20
                                            color: modelData.color
                                            radius: 3
                                            
                                            MouseArea {
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: showEventDetails(modelData)
                                            }
                                            
                                            Label {
                                                anchors.fill: parent
                                                anchors.margins: 2
                                                text: modelData.title 
                                                color: "white"
                                                font.pixelSize: 10
                                                elide: Text.ElideRight
                                            }
                                        }
                                    }
                                }
                                
                                MouseArea {
                                    anchors.fill: parent
                                    onDoubleClicked: {
                                        if (isCurrentMonth) {
                                            // Créer un nouvel événement pour ce jour
                                            editEventDialog.isNewEvent = false;
                                            editEventDialog.eventId = 0;
                                            editEventDialog.title = "Créer un événement";
                                            
                                            // Préremplir avec la date sélectionnée
                                            var year = cellDate.getFullYear();
                                            var month = (cellDate.getMonth() + 1).toString().padStart(2, "0");
                                            var day = cellDate.getDate().toString().padStart(2, "0");
                                            var dateStr = year + "-" + month + "-" + day;
                                            
                                            editEventDialog.eventTitle.text = "";
                                            editEventDialog.startDate.text = dateStr;
                                            editEventDialog.startTime.text = "09:00";
                                            editEventDialog.endDate.text = dateStr;
                                            editEventDialog.endTime.text = "10:00";
                                            editEventDialog.eventDescription.text = "";
                                            
                                            editEventDialog.open();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Vue hebdomadaire (à implémenter)
                Rectangle {
                    id: weekView
                    color: "white"
                    
                    Label {
                        anchors.centerIn: parent
                        text: "Vue hebdomadaire (à venir)"
                    }
                }
                
                // Vue journalière (à implémenter)
                Rectangle {
                    id: dayView
                    color: "white"
                    
                    Label {
                        anchors.centerIn: parent
                        text: "Vue journalière (à venir)"
                    }
                }
            }
        }    
        
        // Dialogue pour créer ou modifier un événement
        Dialog {
            id: editEventDialog
            title: "Créer un événement"
            width: 400
            height: 350
            anchors.centerIn: parent
            modal: true
            background: Rectangle{
                anchors.fill: parent
            }
            
            // Propriétés pour suivre l'état du dialogue
            property bool isNewEvent: true
            property var eventId: null
            
            // Références aux contrôles pour accès facile
            property alias eventTitle: titleField
            property alias startDate: startDateField
            property alias startTime: startTimeField
            property alias endDate: endDateField
            property alias endTime: endTimeField
            property alias eventDescription: descriptionField
            
            contentItem: Rectangle {
                ColumnLayout {
                spacing: 10
                
                Label { text: "Titre:" }
                TextField {
                    id: titleField
                    Layout.fillWidth: true
                    placeholderText: "Titre de l'événement"
                }
                
                Label { text: "Date de début:" }
                RowLayout {
                    Layout.fillWidth: true
                    TextField {
                        id: startDateField
                        Layout.fillWidth: true
                        placeholderText: "AAAA-MM-JJ"
                    }
                    TextField {
                        id: startTimeField
                        Layout.preferredWidth: 100
                        placeholderText: "HH:MM"
                    }
                }
                
                Label { text: "Date de fin:" }
                RowLayout {
                    Layout.fillWidth: true
                    TextField {
                        id: endDateField
                        Layout.fillWidth: true
                        placeholderText: "AAAA-MM-JJ"
                    }
                    TextField {
                        id: endTimeField
                        Layout.preferredWidth: 100
                        placeholderText: "HH:MM"
                    }
                }
                
                Label { text: "Description:" }
                TextArea {
                    id: descriptionField
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "Description de l'événement"
                }
            }
            }
            footer: DialogButtonBox {
                Button {
                    text: "Enregistrer"
                    DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                }
                Button {
                    text: "Annuler"
                    DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
                }
                
                onAccepted: {
                    // Créer un nouveau QDateTime à partir des champs
                    var startDateParts = startDateField.text.split('-').map(Number);
                    var startTimeParts = startTimeField.text.split(':').map(Number);
                    
                    var startDateTime = new Date(startDateParts[0], startDateParts[1]-1, startDateParts[2], 
                                                startTimeParts[0], startTimeParts[1]);
                    
                    var endDateParts = endDateField.text.split('-').map(Number);
                    var endTimeParts = endTimeField.text.split(':').map(Number);
                    
                    var endDateTime = new Date(endDateParts[0], endDateParts[1]-1, endDateParts[2], 
                                              endTimeParts[0], endTimeParts[1]);
                    
                    if (editEventDialog.isNewEvent) {
                        // Ajouter un nouvel événement via notre modèle Python
                        eventModel.addEvent(titleField.text, startDateTime, endDateTime, descriptionField.text);
                    } else {
                        // Mettre à jour un événement existant
                        eventModel.updateEvent(editEventDialog.eventId, titleField.text, startDateTime, endDateTime, descriptionField.text);
                    }
                    
                    editEventDialog.close();
                    updateCalendar();
                }
                
                onRejected: editEventDialog.close()
            }


        }
        
        // Dialogue de détails d'événement
        Dialog {
            id: eventDetailsDialog
            title: "Détails de l'événement"
            width: 400
            height: 300
            anchors.centerIn: parent
            modal: true
            
            property var currentEvent: null
            
            contentItem: ColumnLayout {
                spacing: 10
                
                Label { 
                    id: detailsTitle
                    font.bold: true
                    font.pixelSize: 16
                    text: eventDetailsDialog.currentEvent ? eventDetailsDialog.currentEvent.title : ""
                }
                
                Label { 
                    id: detailsTime
                    text: {
                        if (eventDetailsDialog.currentEvent) {
                            var start = new Date(eventDetailsDialog.currentEvent.start);
                            var end = new Date(eventDetailsDialog.currentEvent.end);
                            var dateStr = start.toLocaleDateString();
                            var timeStr = start.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'}) + 
                                        " - " + 
                                        end.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
                            return dateStr + " • " + timeStr;
                        }
                        return "";
                    }
                }
                
                Label { 
                    id: detailsDescription
                    text: eventDetailsDialog.currentEvent ? (eventDetailsDialog.currentEvent.description || "Pas de description") : ""
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
            
            footer: DialogButtonBox {
                Button {
                    text: "Modifier"
                    DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                }
                Button {
                    text: "Supprimer"
                    DialogButtonBox.buttonRole: DialogButtonBox.DestructiveRole
                }
                Button {
                    text: "Fermer"
                    DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
                }
                
                onAccepted: {
                    // Ouvrir dialogue de modification
                    if (eventDetailsDialog.currentEvent) {
                        var event = eventDetailsDialog.currentEvent;
                        
                        // Configurer le dialogue de modification
                        editEventDialog.isNewEvent = false;
                        editEventDialog.eventId = event.id;
                        editEventDialog.title = "Modifier l'événement";
                        
                        // Préremplir les champs avec les données de l'événement
                        var start = new Date(event.start);
                        var end = new Date(event.end);
                        
                        editEventDialog.eventTitle.text = event.title;
                        editEventDialog.startDate.text = formatDate(start);
                        editEventDialog.startTime.text = formatTime(start);
                        editEventDialog.endDate.text = formatDate(end);
                        editEventDialog.endTime.text = formatTime(end);
                        editEventDialog.eventDescription.text = event.description || "";
                        
                        // Fermer le dialogue de détails et ouvrir celui de modification
                        eventDetailsDialog.close();
                        editEventDialog.open();
                    }
                }
                
                onRejected: eventDetailsDialog.close()
                
                onDiscarded: {
                    // Supprimer l'événement
                    if (eventDetailsDialog.currentEvent) {
                        eventModel.deleteEvent(eventDetailsDialog.currentEvent.id);
                        eventDetailsDialog.close();
                        updateCalendar();
                    }
                }
            }
        }
    }
    
    // Connexion au changement de modèle (si disponible)
    Connections {
        target: eventModel
        function onEventsChanged() {
            updateCalendar();
        }
    }
    
    // Fonctions JavaScript pour gérer le calendrier
    function updateCalendar() {
        switch(mainWindow.currentView) {
            case "month":
                updateMonthView();
                break;
            case "week":
                // updateWeekView(); // À implémenter
                break;
            case "day":
                // updateDayView(); // À implémenter
                break;
        }
    }
    
    function updateMonthView() {
        dateLabel.text = mainWindow.monthNames[mainWindow.currentMonth] + " " + mainWindow.currentYear
        
        // Déterminer le premier jour du mois
        var firstDayOfMonth = new Date(mainWindow.currentYear, mainWindow.currentMonth, 1);
        var dayOfWeek = firstDayOfMonth.getDay(); // 0 = Dimanche, 1 = Lundi, etc.
        
        // Déterminer le nombre de jours dans le mois
        var lastDayOfMonth = new Date(mainWindow.currentYear, mainWindow.currentMonth + 1, 0);
        var daysInMonth = lastDayOfMonth.getDate();
        
        // Déterminer le nombre de jours du mois précédent à afficher
        var daysFromPrevMonth = dayOfWeek;
        
        // Date actuelle pour marquer "aujourd'hui"
        var today = new Date();
        
        // Mettre à jour chaque cellule du calendrier
        for (var i = 0; i < 42; i++) {
            var dayItem = daysRepeater.itemAt(i);
            if (!dayItem) continue;
            
            if (i < daysFromPrevMonth) {
                // Jours du mois précédent
                var prevMonthDate = new Date(mainWindow.currentYear, mainWindow.currentMonth, 0);
                var daysInPrevMonth = prevMonthDate.getDate();
                var day = daysInPrevMonth - (daysFromPrevMonth - 1) + i;
                
                dayItem.cellDate = new Date(mainWindow.currentYear, mainWindow.currentMonth - 1, day);
                dayItem.isCurrentMonth = false;
                dayItem.isToday = false;
                dayItem.children[0].children[0].text = day;
                
            } else if (i >= daysFromPrevMonth && i < daysFromPrevMonth + daysInMonth) {
                // Jours du mois actuel
                var day = (i - daysFromPrevMonth) + 1;
                
                dayItem.cellDate = new Date(mainWindow.currentYear, mainWindow.currentMonth, day);
                dayItem.isCurrentMonth = true;
                dayItem.isToday = (today.getFullYear() === mainWindow.currentYear && 
                                  today.getMonth() === mainWindow.currentMonth && 
                                  today.getDate() === day);
                dayItem.children[0].children[0].text = day;
                
            } else {
                // Jours du mois suivant
                var day = i - (daysFromPrevMonth + daysInMonth) + 1;
                
                dayItem.cellDate = new Date(mainWindow.currentYear, mainWindow.currentMonth + 1, day);
                dayItem.isCurrentMonth = false;
                dayItem.isToday = false;
                dayItem.children[0].children[0].text = day;
            }
            
            // Mettre à jour les événements pour cette cellule
            updateCellEvents(dayItem);
        }
    }
    
    function updateCellEvents(dayItem) {
        var cellDate = dayItem.cellDate;
        var cellEvents = [];
        
        // Filtrer les événements pour cette date
        if (typeof eventModel !== 'undefined' && eventModel.events) {
            for (var i = 0; i < eventModel.events.length; i++) {
                var event = eventModel.events[i];
                var eventDate = new Date(event.start);
                
                if (eventDate.getFullYear() === cellDate.getFullYear() &&
                    eventDate.getMonth() === cellDate.getMonth() &&
                    eventDate.getDate() === cellDate.getDate()) {
                    cellEvents.push(event);
                }
            }
        }
        
        // Mettre à jour la liste des événements pour cette cellule
        dayItem.children[0].children[1].model = cellEvents;
    }
    
    function navigatePrevious() {
        switch(mainWindow.currentView) {
            case "month":
                mainWindow.currentMonth--;
                if (mainWindow.currentMonth < 0) {
                    mainWindow.currentMonth = 11;
                    mainWindow.currentYear--;
                }
                break;
            case "week":
                // À implémenter
                break;
            case "day":
                mainWindow.currentDay--;
                var tempDate = new Date(mainWindow.currentYear, mainWindow.currentMonth, mainWindow.currentDay);
                mainWindow.currentYear = tempDate.getFullYear();
                mainWindow.currentMonth = tempDate.getMonth();
                mainWindow.currentDay = tempDate.getDate();
                break;
        }
        updateCalendar();
    }
    
    function navigateNext() {
        switch(mainWindow.currentView) {
            case "month":
                mainWindow.currentMonth++;
                if (mainWindow.currentMonth > 11) {
                    mainWindow.currentMonth = 0;
                    mainWindow.currentYear++;
                }
                break;
            case "week":
                // À implémenter
                break;
            case "day":
                mainWindow.currentDay++;
                var tempDate = new Date(mainWindow.currentYear, mainWindow.currentMonth, mainWindow.currentDay);
                mainWindow.currentYear = tempDate.getFullYear();
                mainWindow.currentMonth = tempDate.getMonth();
                mainWindow.currentDay = tempDate.getDate();
                break;
        }
        updateCalendar();
    }
    
    function showEventDetails(event) {
        eventDetailsDialog.currentEvent = event;
        eventDetailsDialog.title = "Événement: " + event.title;
        eventDetailsDialog.open();
    }
    
    // Fonctions utilitaires pour le formatage des dates
    function formatDate(date) {
        var year = date.getFullYear();
        var month = (date.getMonth() + 1).toString().padStart(2, "0");
        var day = date.getDate().toString().padStart(2, "0");
        return year + "-" + month + "-" + day;
    }
    
    function formatTime(date) {
        var hours = date.getHours().toString().padStart(2, "0");
        var minutes = date.getMinutes().toString().padStart(2, "0");
        return hours + ":" + minutes;
    }
    
    // Initialiser le calendrier au démarrage
    Component.onCompleted: {
        updateCalendar();
    }
}
