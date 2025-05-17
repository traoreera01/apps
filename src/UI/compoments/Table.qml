import QtQuick 2.15
import QtQuick.Controls.Basic 2.15

Item {
    id: root
    signal clicked(int row, var rowData)
    width: 600
    height: 300
    // Propriétés publiques
    property var headerModel: [
        {text: 'Nom', width: 0.4},
        {text: 'Taille', width: 0.1},
        {text: 'Type', width: 0.1},
        {text: 'Date', width: 0.2},
        {text: 'test', width: 0.1}
    ]
    property var dataModel:[]

    property color headerColor: "#f8f8f8"
    property color textColor: "#5a5a5a"
    property color headerCeparatorColor: "#e0e0e0"
    property color bodyContentColor1: "#fff"
    property color bodyContentColor2: "#fff"
    property color bodyTextColor: "#4a4a4a"
    property color scrollIndicatorColor:"#a0a0a0"
    property color scrollBackColor:"#e0e0e0"
    Rectangle {
        id: header
        width: parent.width
        height: 40
        color: root.headerColor || "#f8f8f8"
        border.color: root.headerColor || "#f8f8f8"
        ListView {
            anchors.fill: parent
            orientation: ListView.Horizontal
            interactive: false
            model: headerModel
            delegate: Item {
                width: modelData.width * root.width
                height: 30
                Text {
                    anchors.centerIn: parent
                    text: modelData.text
                    font.pixelSize: 16
                    color: root.textColor || "#5a5a5a" // Gris sombre
                    font.family: "Helvetica Neue"
                }
                Rectangle{
                    height: header.height
                    width: 1
                    border.width : 1
                    color : root.headerCeparatorColor
                    border.color : root.headerCeparatorColor
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
            color : root.headerCeparatorColor ||'lightgray'
            border.color : root.headerCeparatorColor ||'lightgray'
            width: parent.width
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
                color: index % 2 === 0 ? root.bodyContentColor1 : root.bodyContentColor2 || "#fff"

                Row {
                    anchors.fill: parent
                    Repeater {
                        model: modelData
                        delegate: Item {
                            MouseArea{
                                width: headerModel[index].width * root.width
                                height: parent.height
                                onClicked: console.log(index);
                            }
                            width: headerModel[index].width * root.width
                            height: parent.height
                            Image{
                                id: icon
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin:0
                                width: 20
                                height: 20
                                source: icons.pdf
                                visible: if(index===0){
                                    tes_.horizontalAlignment = Text.AlignLeft
                                    tes_.width =parent.width -45
                                    return true}else{return false}
                            }
                            Text {
                                id: tes_
                                text: modelData
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                color: root.bodyTextColor
                                font.family: "Helvetica Neue"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                
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
                color: root.scrollIndicatorColor
            }
            background: Rectangle {
                anchors.fill: parent
                radius: 7
                color: root.scrollBackColor
            }
        }
    }
}
