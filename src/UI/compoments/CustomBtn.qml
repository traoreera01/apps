import QtQuick 6.5
import QtQuick.Controls.Basic 2.15

/*
*/

Button {
    id: btnLeftMenu
    property color colorDefaut: "#0f1218"
    property color colorClik: "#00a1f1"
    property color colorMouse: "#23272E"
    property url btIcon: "../src/ico/chevron-right.svg"
    property bool isActiveMenu: true
    property string btnText: "Settings"
    property bool isImgActive: true
    property bool is_active: true
    QtObject {
        id: internal
        property var dynamicColor: if (btnLeftMenu.down) {
                                       btnLeftMenu.down ? colorClik : colorDefaut
                                   } else {
                                       btnLeftMenu.hovered ? colorMouse : colorDefaut
                                   }
    }
    width: 150
    height: 32
    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        //radius: 10
    }
    Image {
        id: btnIcons
        width: 20
        height: 20
        anchors.left: parent.left
        source: btnLeftMenu.btIcon || ""
        mirror: false
        anchors.leftMargin: 5
        visible: isImgActive
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        id: is_activeBtn
        height: parent.height
        width: 3
        visible: btnLeftMenu.is_active
    }

    contentItem: Text {
        id: custnBtnText
        text: btnText
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: btnIcons.right
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 13
        anchors.leftMargin: 10
        clip: true
        width: 65
        height: 20
        font.bold: true
        color: "#ffffff"
    }
}
