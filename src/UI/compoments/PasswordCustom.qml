import QtQuick 2.15
import QtQuick.Controls.Basic 2.15

//MAKE :
 
TextField {
    id: textField

    // Custom Properties
    property color colorDefault: "#282c34"
    property color colorOnFocus: "#242831"
    property color colorMouseOver: "#2B2F38"
    property color borderOnFocus: "#ff007f"
    selectByMouse: false
    selectedTextColor: "#FFFFFF"
    selectionColor: "#ff007f"
    placeholderTextColor: "#81848c"
    property bool amimationRun: true
    property url eye_on_img:  "../src/ico/1x.svg"
    property url eye_off_img:  "../src/ico/1y.svg"
    font.pointSize: 10
    echoMode: TextInput.Password
    property int radius: 10
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
    placeholderText: qsTr("Votre mot de passe")
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
    }
    Image {
        id: keyImage
        source: "../src/ico/key.svg"
        sourceSize.height: 20
        anchors.leftMargin: 10
        opacity: 0.5
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }
    Image {
        id: cleanImg
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        horizontalAlignment: Image.AlignLeft
        source: textField.eye_off_img
        anchors.rightMargin: 10
        fillMode: Image.PreserveAspectFit
        sourceSize.height: 20
        opacity: 0.5
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                if (textField.echoMode === TextInput.Normal) {
                    textField.echoMode = TextInput.Password
                    cleanImg.source = textField.eye_on_img
                } else {
                    textField.echoMode = TextInput.Normal
                    cleanImg.source = textField.eye_off_img
                }
            }
        }
    }
    onFocusChanged: {
        if (textField.focus) {
            textOnFocus.running = textField.amimationRun
            cleanImg.visible = true
            bgColor.border.color = borderOnFocus
        } else {
            textoffFocus.running = textField.amimationRun
            cleanImg.visible = false
            bgColor.border.color = "#282c34"
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
