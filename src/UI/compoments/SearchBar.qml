import QtQuick
import QtQuick.Controls.Basic 6.5
Rectangle{
    id: root
    implicitHeight: 50
    implicitWidth:400
    property string placeholder:"Rechercher un document"
    property color colorDefault:"#fff"
    property color colorOnFocus:"#242831"
    property color colorMouseOver:"#2B2F38"
    property color borderOnFocus:"#ff007f"
    property color selectionTextColor:"#2f2f2f"
    property color separatorColor:  "lightgray"
    property color contentImg: "#a27744"
    property color textColor: "#000"
    property url iconUrl: "../src/ico/search.svg"
    property bool on_off_line: true // true => online || false => offline 
    width: 500
    color: "#ffffff"
    radius: 20
    QtObject{
        id: internal
        property var dynamicColor: if (searchField.focus){
                                       searchField.focus ? root.colorOnFocus: root.colorDefault
                                   }else{
                                       searchField.focus ? root.colorMouseOver: root.colorDefault
                                   }
        function searchOnline(search){
                if (search.text !== "") {
                    //searchBook.search(search.text); // TODO: remove this and add methode to search online => using api
                    //listContent.myList = books_authors;
                    //console.log(listContent.myList[0])
                }
                if (search.text === "") {
                    console.log("test complete");
                    //searchBook.initialBook(); // TODO: remove this and add methode to search online => using api
                    //listContent.myList = books_authors;
                    //console.log(listContent.myList)
                }
        }
        function searchOffline(search){
                if (search.text !== "") {
                    searchBook.search(search.text);
                    //listContent.myList = books_authors; // TODO: remove this and add methode to search online => using didf algo and completion 
                    //console.log(listContent.myList[0])
                }
                if (search.text === "") {
                    console.log("test complete");
                    //searchBook.initialBook();// TODO: remove this and add methode to search online => using didf algo and completion 
                    //listContent.myList = books_authors;
                    //console.log(listContent.myList)
                }

        }
    }
    PropertyAnimation {
        // animation for label font size
        id: animation
        target: searchLabel
        property: "font.pointSize"
        easing.bezierCurve: [0.0415,0.435,0.84,0.65,1,1]
        duration: 500
    }
    TextField{
        id: searchField
        width: 285
        height: 28
        color: "#000000"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        verticalAlignment: Text.AlignTop
        placeholderTextColor: "#f6000000"
        clip: true
        selectedTextColor: root.selectionTextColor
        selectionColor:root.selectionTextColor
        font.pointSize: 8
        placeholderText:root.placeholder
        onTextChanged: if(root.on_off_line){
            internal.searchOnline(searchField);
        }else{
            internal.searchOffline(searchField)
        }

        anchors.verticalCenterOffset: 0
        background: Rectangle{
            anchors.fill: parent
            border.color: root.color
            color:root.color
        }
    }

    Rectangle{
        id: separator
        width:1
        color: root.separatorColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: searchField.right
        anchors.leftMargin: 1
        height: 28
    }
    Label{
        id: searchLabel
        x: 210
        width: 95
        height: 16
        text: "EII,2002,license 1"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: separator.right
        anchors.leftMargin: 16
        font.pointSize: 9
        clip: true
        color: root.textColor
        MouseArea{
            id:clikEvents
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                 //searchLabel.font.bold = true
                
                animation.from = 9
                animation.to = 10
                animation.running = true
            }
            onExited: {
                 //searchLabel.font.bold = false
                animation.from = 10
                animation.to = 9
                animation.running = true
            }
            onClicked: {
                popContentherrr.width = 500
                popContentherrr.height = 500
                popContentherrr.open()
                loderDescription.source = "SearchSettings.qml"
            }
        }
    }

    Rectangle {
        id: rectangle
        width: 30
        height: 30
        color: root.contentImg
        radius: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        clip: true

        Image{
            width: 15
            height: 15
            anchors.verticalCenter: parent.verticalCenter
            source: root.iconUrl || ""
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
        }
    }

}
