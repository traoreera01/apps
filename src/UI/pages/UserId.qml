import QtQuick 2.15
import QtQuick.Controls 2.15
import "../compoments"
import "../effect"

Item {
    id:root
    width: 900
    height: 500
    Rectangle {
        id: content_user_
        width: 450
        height: 428
        color: params.userId.color
        radius: 10
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        Rectangle {
            id: rectangle
            width: 85
            height: 21
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 30
            anchors.topMargin: 30
            clip: true
            color: "transparent"
            Image {
                id: app_img
                x: 0
                y: 0
                width: 20
                height: 20
                source: "../src/images/eror404.jpg"
                fillMode: Image.PreserveAspectFit
            }

            Label {
                id: label
                y: 0
                width: 60
                height: 20
                color: params.userId.textColor
                text: qsTr("BIBLIOapp")
                anchors.left: app_img.right
                anchors.leftMargin: 5
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }
        }
        Label {
            id: label1
            x: 0
            y: 118
            width: 218
            height: 20
            color: params.userId.textColor || "#000"
            text: qsTr("Information utilisateur")
            anchors.bottom: user_input_.top
            anchors.bottomMargin: 20
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 15
            font.bold: true
        }
        Column {
            id: user_input_
            width: 328
            height: 111
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 15
            spacing: 10
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            CustomTextField {
                id: customTextField
                width: user_input_.width
                height: 50
                controlsHover: false
                amimationRun: false
                iconUrl2: icons.user||"../src/ico/user.svg"
                iconUrl: ""
                placeholderText: qsTr("Email ou nom d'utilisateur")
                colorDefault: controlsThemes.textfield.colorDefault
                colorOnFocus: controlsThemes.textfield.colorOnFocus 
                colorMouseOver: controlsThemes.textfield.colorMouseOver 
                borderOnFocus: controlsThemes.textfield.borderOnFocus 
                selectedTextColor: controlsThemes.textfield.selectedTextColor 
                selectionColor: controlsThemes.textfield.selectionColor 
                placeholderTextColor: controlsThemes.textfield.placeholderTextColor 
            }
            PasswordCustom {
                id: passwordCustom
                width: user_input_.width
                height: 50
                amimationRun: false
                eye_off_img: icons.y
                eye_on_img: icons.x
                colorDefault: controlsThemes.textfield.colorDefault
                colorOnFocus: controlsThemes.textfield.colorOnFocus 
                colorMouseOver: controlsThemes.textfield.colorMouseOver 
                borderOnFocus: controlsThemes.textfield.borderOnFocus 
                selectedTextColor: controlsThemes.textfield.selectedTextColor 
                selectionColor: controlsThemes.textfield.selectionColor 
                placeholderTextColor: controlsThemes.textfield.placeholderTextColor 
            }
        }
        Custom {
            id: custom
            width: user_input_.width
            anchors.top: user_input_.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            clikColor: controlsThemes.custom.clikColor
            defaultColor: controlsThemes.custom.otherParams.defaultColor
            textColor: controlsThemes.custom.otherParams.textColor
            widthIndicator: controlsThemes.custom.widthIndicator
            raduisIn: controlsThemes.custom.raduisIn
            hoverColor: controlsThemes.custom.hoverColor
            indicatorColor: controlsThemes.custom.indicatorColor
            borderColor: controlsThemes.custom.borderColor
            borderWidh: controlsThemes.custom.borderWidh
        }


    }
}
