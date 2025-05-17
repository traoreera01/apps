import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import "../effect" 
Rectangle{
    id:root
    width: 100
    height: 100
    radius: root.radius_mask
    property int radius_mask: 10

    border.width: 0
    property url source: "../src/images/onedark-bash.png"
    Rectangle {
        id: ppImg
        color: "#00ffffff"
        radius: 0
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        border.width: 0
        Image {
            id: img1
            visible: false
            anchors.fill: parent
            source: root.source || "../src/images/onedark-bash.png"
            clip: true
        }
        Item {
            id: mask1
            visible: false
            anchors.fill: parent
            Rectangle {
                color: "#fff"
                radius: root.radius_mask
                border.width: 0
                anchors.fill: parent
                clip: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
            clip: true
        }
        OpacityMaskEffect {
            anchors.fill: parent
            source: img1
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            maskSource: mask1
            clip: true
        }
        clip: true
    }
}
