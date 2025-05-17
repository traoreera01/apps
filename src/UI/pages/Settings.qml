import QtQuick 2.0 // type: ignore
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import "../compoments"
import "../pages"
import "../effect"
import "../src/images"
import Qt5Compat.GraphicalEffects

Item {
    id: window
    width: if(parent.width === null) { return 1100 } else {return parent.width }
    height: if (parent.height === null) { return 700 } else {return parent.height }

    QtObject{
        id: internal_Settings
        function profileCliked(){
            profile.textColor = controlsThemes.custom.textCliked
            profile.defaultColor = controlsThemes.custom.clikColor
            
            user_id.textColor = controlsThemes.custom.textColor
            user_id.defaultColor = controlsThemes.custom.defaultColor
            
            notification.textColor = controlsThemes.custom.textColor
            notification.defaultColor = controlsThemes.custom.defaultColor
            
            user_themes.textColor = controlsThemes.custom.textColor
            user_themes.defaultColor = controlsThemes.custom.defaultColor

            loader.source = "Profile.qml"
        }
        function userCliked(){
            profile.textColor = controlsThemes.custom.textColor
            profile.defaultColor = controlsThemes.custom.defaultColor
            
            user_id.textColor = controlsThemes.custom.textCliked
            user_id.defaultColor = controlsThemes.custom.clikColor
            
            notification.textColor = controlsThemes.custom.textColor
            notification.defaultColor = controlsThemes.custom.defaultColor

            user_themes.textColor = controlsThemes.custom.textColor
            user_themes.defaultColor = controlsThemes.custom.defaultColor

            loader.source = "UserId.qml"
        }
        function notificationCliked(){
            profile.textColor = controlsThemes.custom.textColor
            profile.defaultColor = controlsThemes.custom.defaultColor
            
            user_id.textColor = controlsThemes.custom.textColor
            user_id.defaultColor = controlsThemes.custom.defaultColor
            
            notification.textColor = controlsThemes.custom.textCliked
            notification.defaultColor = controlsThemes.custom.clikColor

            user_themes.textColor = controlsThemes.custom.textColor
            user_themes.defaultColor = controlsThemes.custom.defaultColor
            loader.source = "NotifSettings.qml"
        }
        function themesCliked(){
            profile.textColor = controlsThemes.custom.textColor
            profile.defaultColor = controlsThemes.custom.defaultColor
            
            user_id.textColor = controlsThemes.custom.textColor
            user_id.defaultColor = controlsThemes.custom.defaultColor
            
            notification.textColor = controlsThemes.custom.textColor
            notification.defaultColor = controlsThemes.custom.defaultColor

            user_themes.textColor = controlsThemes.custom.textCliked
            user_themes.defaultColor = controlsThemes.custom.clikColor
        }
    }

    Rectangle {
        id: headers
        height: 70.8
        color: params.headerColor || "#005eff"
        border.width: 0
        width: parent.width
        anchors.top: parent.top

        Text {
            id: text1
            color: params.headerTextColor || "#fff"
            text: qsTr("Reglages")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 0
            font.bold: true
        }
    }
    // body 
    Rectangle {
        id: rectangle
        color: params.rectangle.color || "#ffffff"
        border.width: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: headers.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        Rectangle {
            id: menu
            height: 66
            color: params.rectangle.menuColor || "#fbfdff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: -1
            Row {
                id: row
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 120
                anchors.rightMargin: 300
                spacing: 20
                clip: true
                Custom {
                    id: profile
                    width: 90
                    text: "Profile"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked: internal_Settings.profileCliked()
                }
                Custom {
                    id: user_id
                    width: 90
                    text: "User ID"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked: internal_Settings.userCliked()
                }
                Custom {
                    id: notification
                    width: 100
                    text: "Notifications"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked: internal_Settings.notificationCliked()
                }

                Custom {
                    id: user_themes
                    width: 90
                    text: "UI themes"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked: internal_Settings.themesCliked()
                }
            }
            Rectangle {
                id: end_menu_
                y: 34
                width: menu.width
                height: 1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                color: params.rectangle.menuHandColor
                border.color: "lightgray"
            }
        }
        Loader {
            id: loader
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: menu.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            source: "License.qml"
        }
    }
}

