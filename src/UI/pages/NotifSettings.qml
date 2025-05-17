import QtQuick 2.15
import QtQuick.Controls 2.15
import "../compoments"
import "../effect"


Rectangle{
    id: bg
    anchors.fill:parent
    color:  "transparent"
    border.width: 0
    Rectangle {
        id: content
        color: "transparent"
        border.width: 0
        border.color:  "transparent"
        anchors.top: bg.top
        anchors.right: bg.right
        anchors.bottom: bg.bottom
        anchors.left: bg.left
        anchors.bottomMargin: 100
        anchors.leftMargin : 100
        anchors.rightMargin: 100
        anchors.topMargin: 100

        Rectangle {
            id: rectangle
            height: 58
            color: params.notification.rect1
            radius: 5
            border.width: 0
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin:0
            anchors.leftMargin: 0
            anchors.topMargin: 78
            
            Text {
                id: text1
                anchors.left:parent.left
                anchors.leftMargin: 10
                text: qsTr("Notification des mise a jour du systeme")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                color: params.notification.textColor
            }

            CustomSwith {
                id: systeme
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                darkImgUrl: "" // icons.moon
                lightImgUrl: "" //icons.sun
                checkColor: controlsThemes.customswith.checkColor
                unchekColor: controlsThemes.customswith.unchekColor
                roundColor: controlsThemes.customswith.roundColor
            }
            MouseArea {
                anchors.fill: parent
                anchors.rightMargin: 80
                clip: true
                hoverEnabled: true
                onClicked: {
                    if (systeme.checked) {
                        systeme.checked = 0;
                    } else {
                        systeme.checked = 1;
                    }
                }
            }
        }
        DropShadowEffect {
            id: drop
            anchors.fill: rectangle
            source: rectangle
            color: controlsThemes.dropEffect.colorEffect || "#4d241d1dd1d"
            radius:controlsThemes.dropEffect.radius || 7
            samples: controlsThemes.dropEffect.samples || 16
            spread: controlsThemes.dropEffect.spread || 0
            anchors.leftMargin: -.5
            anchors.rightMargin:0
            anchors.topMargin: 1
            anchors.bottomMargin: -1
            verticalOffset: 0
            horizontalOffset: 0
        }
        
        Rectangle {
            id: rectangle1
            width: parent.width
            height: 58
            color: params.notification.rect1//params.notification.color
            radius: 5
            border.width: 0
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin:0
            anchors.leftMargin: 0
            anchors.topMargin: 160

            Text {
                id: text2
                anchors.left:parent.left
                anchors.leftMargin: 10
                text: qsTr("Notification du systeme Sonore")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                color: params.notification.textColor
            }
            CustomSwith {
                id: systeme1
                width: 64
                height: 39
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                darkImgUrl: ""//icons.moon
                lightImgUrl: ""//icons.sun

                checked: notificationConfig['audio_active']
                checkColor: controlsThemes.customswith.checkColor
                unchekColor: controlsThemes.customswith.unchekColor
                roundColor: controlsThemes.customswith.roundColor
            }

            MouseArea {
                anchors.fill: parent
                anchors.rightMargin: 80
                onClicked: {
                    if (systeme1.checked) {
                        systeme1.checked = 0;
                    } else {
                        systeme1.checked = 1;
                    }
                }
                hoverEnabled: true
                clip: true
            }
        }
        DropShadowEffect {
            id: drop1
            anchors.fill: rectangle1
            source: rectangle1
            color: controlsThemes.dropEffect.colorEffect || "#4d241d1dd1d"
            radius:controlsThemes.dropEffect.radius || 7
            samples: controlsThemes.dropEffect.samples || 16
            spread: controlsThemes.dropEffect.spread || 0
            anchors.leftMargin: -.5
            anchors.rightMargin:0
            anchors.topMargin: 1
            anchors.bottomMargin: -1
            verticalOffset: 0
            horizontalOffset: 0
        }
        Rectangle {
            id: rectangle2
            width: parent.width
            height: 58
            color: params.notification.rect1
            radius: 5
            border.width: 0
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin:0
            anchors.leftMargin: 0
            anchors.topMargin: 244
            Text {
                id: text3
                text: qsTr("Notification du systeme ")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:parent.left
                anchors.leftMargin: 10
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                color: params.notification.textColor
            }
            CustomSwith {
                id: systeme2
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                checkColor: controlsThemes.customswith.checkColor
                unchekColor: controlsThemes.customswith.unchekColor
                roundColor: controlsThemes.customswith.roundColor
                
                darkImgUrl: ""//icons.moon
                lightImgUrl: ''//icons.sun
                checked: notificationConfig['msgDisplay']
            }
            MouseArea {
                anchors.fill: parent
                anchors.rightMargin: 80
                onClicked: {
                    if (systeme2.checked) {
                        systeme2.checked = 0;
                    } else {
                        systeme2.checked = 1;
                    }
                }
                hoverEnabled: true
                clip: true
            }
        }
        DropShadowEffect {
            id: drop2
            anchors.fill: rectangle2
            source: rectangle2
            color: controlsThemes.dropEffect.colorEffect || "#4d241d1dd1d"
            radius:controlsThemes.dropEffect.radius || 7
            samples: controlsThemes.dropEffect.samples || 16
            spread: controlsThemes.dropEffect.spread || 0
            anchors.leftMargin: -.5
            anchors.rightMargin:0
            anchors.topMargin: 1
            anchors.bottomMargin: -1
            verticalOffset: 0
            horizontalOffset: 0
        }
    }

    Custom {
        width: 104
        height: 40
        text: "Soumetre"
        anchors.right: parent.right
        anchors.top: content.bottom
        anchors.topMargin: 20
        anchors.rightMargin: 20
        clikColor: controlsThemes.custom.clikColor
        defaultColor: controlsThemes.custom.defaultColor
        textColor: controlsThemes.custom.textColor
        widthIndicator: controlsThemes.custom.widthIndicator
        raduisIn: controlsThemes.custom.raduisIn
        hoverColor: controlsThemes.custom.hoverColor
        indicatorColor: controlsThemes.custom.indicatorColor
        borderColor: controlsThemes.custom.borderColor
        borderWidh: controlsThemes.custom.borderWidh
        onClicked: {
            appSetting.notifSettings(systeme1.checked, systeme2.checked);
            updateUI.updatingUserInterface();
            //loader.source = "License.qml";
        }
    }
}