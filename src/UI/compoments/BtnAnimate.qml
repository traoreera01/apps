import QtQuick 2.15
import QtQuick.Controls.Basic 2.15

/*
    version: 
    author:
    TODO: 
*/

Button{
    id:root
    implicitHeight: 30
    implicitWidth: 200
    property color bgColor : "#2f2f2f"
    property color textColor: "#fff"
    property url icoUrls :"src/images/nord-Minimal-Nord.png" 
    property int raduisIn: 10
    property bool clikedIs: false
    text: "bouton d'animation"

    background: Rectangle{
        id: bg
        anchors.fill: parent
        color: root.bgColor
        radius: root.raduisIn
    }
    contentItem: Text {
        id: name
        width: 100
        color: enabled ? root.textColor : root.bgColor
        text: root.text
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: test.right
        anchors.leftMargin: 8
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Regular"
        font.family: "Segoe UI"
        clip: true
        anchors.horizontalCenterOffset: 1
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Image {
        id: test
        source: root.icoUrls || ""
        fillMode: Image.PreserveAspectCrop
        width: 15
        height: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
}
