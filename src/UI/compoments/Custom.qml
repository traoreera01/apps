import QtQuick 2.15
import QtQuick.Controls.Basic 2.15


/*
    TODO: 
*/
Button{
    id: root
    implicitWidth: 250
    implicitHeight: 40
    text: "integrations"  
    property color clikColor: "#eaf0ff"
    property color defaultColor: "#fff"
    property color textColor: "#000"
    property int widthIndicator: 0
    property int raduisIn: 5
    property color hoverColor: "#fff"
    property color indicatorColor : "#000"
    property color borderColor: "transparent"
    property int borderWidh: 0

    QtObject{
        id: internal
        property var dynamicColor:if(root.down){root.down ? root.clikColor : root.defaultColor}
                                  else{root.hovered ? root.hoverColor : root.defaultColor}
    }
    

    background: Rectangle{
        id:bg
        anchors.fill: parent
        border.width: root.borderWidh
        color: internal.dynamicColor
        radius: root.raduisIn
        border.color: root.borderColor
    }

    contentItem: Text {
        id: name
        text: root.text
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 11
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        color: root.textColor
    }
}
