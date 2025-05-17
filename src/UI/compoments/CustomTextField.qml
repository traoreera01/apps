import QtQuick 2.15
import QtQuick.Controls.Basic 2.15

TextField {
    id: textField

    // Custom Properties
    property color colorDefault: "#282c34"
    property color colorOnFocus: "#242831"
    property color colorMouseOver: "#2B2F38"
    property color borderOnFocus: "#ff007f"
    property bool amimationRun: true
    property url iconUrl: "../src/ico/search.svg"
    property url iconUrl2: "../src/ico/search.svg"
    property int radius: 10
    property string userInput : ""
    property bool controlsHover: true
    font.pointSize: 10
    font.family: "Segoe UI"
    QtObject {
        id: internal

        property var dynamicColor: if (textField.focus) {
                                       textField.focus ? colorOnFocus : colorDefault
                                   } else {
                                       textField.focus ? colorMouseOver : colorDefault
                                   }
    }
    implicitWidth: 40
    implicitHeight: 40
    placeholderText: qsTr("rechercher un livre")
    color: "#ffffff"
    clip: true
    leftPadding: 42
    rightPadding: 35
    background: Rectangle {
        id: bgColor
        color: internal.dynamicColor
        border.color: "#282c34"
        border.width: 2
        radius: textField.radius
        clip: true

        Image {
            id: searchImg
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            horizontalAlignment: Image.AlignLeft
            source: iconUrl || ""
            anchors.leftMargin: 10
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 20
            opacity: 0.5
        }

        Image {
            id: cleanImg
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            horizontalAlignment: Image.AlignLeft
            source: textField.iconUrl2 ||""
            anchors.rightMargin: 10
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 20
            opacity: 0.5
        }
        MouseArea {
            cursorShape: Qt.PointingHandCursor
            anchors.fill: cleanImg
            onEntered: cleanImg.opacity = 0.75
            onExited: cleanImg.opacity = 0.5
            visible: textField.amimationRun
        }
    }

    selectByMouse: true
    selectedTextColor: "#FFFFFF"
    selectionColor: "#ff007f"
    placeholderTextColor: "#81848c"

    onFocusChanged: {

        if (textField.focus) {
            textOnFocus.running = textField.amimationRun
            cleanImg.visible = true
            bgColor.border.color = borderOnFocus
        }else {
            if (textField.controlsHover === true){
                textoffFocus.running = textField.amimationRun
                textField.userInput = textField.text
                textField.text = ""
                cleanImg.visible = false
                bgColor.border.color = "#282c34"
            }
            else{
                textoffFocus.running = textField.amimationRun
                bgColor.border.color = "#282c34"
            }
        }

    }

    PropertyAnimation {
        id: textOnFocus
        target: textField
        property: "width"
        to: 300
        duration: 500
        easing.type: Easing.OutQuint
    }
    PropertyAnimation {
        id: textoffFocus
        target: textField
        property: "width"
        to: 40
        duration: 500
        easing.type: Easing.OutQuint
    }
}
