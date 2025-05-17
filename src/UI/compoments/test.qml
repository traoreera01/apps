import QtQuick 2.15
import QtQuick.Controls.Basic 2.15

Item {
    id: root

    // Propriétés publiques
    property var headerModel: [
        {text: 'Nom', width: 0.4},
        {text: 'Taille', width: 0.1},
        {text: 'Type', width: 0.1},
        {text: 'Date', width: 0.2},
        {text: 'test', width: 0.1}
    ]

    property var dataModel:[]

    signal clicked(int row, var rowData)

    width: 600
    height: 300

    Rectangle {
        id: header
        width: parent.width
        height: 40
        color: "#f8f8f8"
        border.color: "#e0e0e0"

        ListView {
            anchors.fill: parent
            orientation: ListView.Horizontal
            interactive: false
            model: headerModel

            delegate: Item {
                width: modelData.width * root.width
                height: parent.height

                Text {
                    anchors.centerIn: parent
                    text: modelData.text
                    font.pixelSize: 16
                    color: "#5a5a5a" // Gris sombre
                    font.family: "Helvetica Neue"
                }
                Rectangle{
                    height: parent.height
                    width: 1
                    border.width : 1
                    color : '#e0e0e0'
                    border.color : '#e0e0e0'
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    visible:  if (index === 0){return false}else{return true}

                }
            }
        }
        Rectangle{
            id: and_header
            border.width : 1
            height: 1
            color : 'lightgray'
            border.color : 'lightgray'
            width: parent.width - 60
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }
    }

    ListView {
        id:table
        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: parent.bottom
        }
        model: dataModel
        clip: true
        cacheBuffer: 100

        delegate: Item {
            width: root.width
            height: 30
            Rectangle {
                anchors.fill: parent
                color: index % 2 === 0 ? "#ffffff" : "#ffffff"
                Row {
                    anchors.fill: parent
                    Repeater {
                        model: modelData
                        delegate: Item {
                            width: headerModel[index].width * root.width
                            height: parent.height
                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                font.pixelSize: 14
                                color: "#4a4a4a"
                                font.family: "Helvetica Neue"
                            }
                        }
                    }
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            width: 15
            policy: ScrollBar.AsNeeded

            contentItem: Rectangle {
                width: parent.width
                height: 6
                radius: 3
                color: "#a0a0a0"
            }

            background: Rectangle {
                anchors.fill: parent
                radius: 7
                color: "#e0e0e0"
            }
        }
    }
}