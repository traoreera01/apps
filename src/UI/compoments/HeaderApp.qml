import QtQuick
import QtQuick.Controls
import "../effect"
Item {
    id: root
    implicitWidth: 1000
    implicitHeight: 70.5
    property bool searchBarVisible: true
    Rectangle {
        id: header
        height: 70
        color: controlsThemes.headerApp.color
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        clip: true
            gradient: Gradient {
            GradientStop { position: 0.0; color: "#005eff"}
            GradientStop { position: 1.0; color: "#175cd3" }
        }
        Rectangle {
            id: separator_menu
            width: 2
            opacity: 0.2
            color: controlsThemes.headerApp.separator_color
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            clip: true
        }
        SearchBar {
            id: searchBar
            width:500
            height: 38
            radius: 10
            visible: root.searchBarVisible
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: -150
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 1
            clip: true
             // other properties color for the searchBar
            colorDefault: controlsThemes.headerApp.searchBar.colorDefault
            colorOnFocus: controlsThemes.headerApp.searchBar.colorOnFocus
            colorMouseOver: controlsThemes.headerApp.searchBar.colorMouseOver
            borderOnFocus: controlsThemes.headerApp.searchBar.borderOnFocus
            selectionTextColor: controlsThemes.headerApp.searchBar.selectionTextColor
            separatorColor: controlsThemes.headerApp.searchBar.separatorColor
            contentImg: controlsThemes.headerApp.searchBar.contentImg
            textColor: controlsThemes.headerApp.searchBar.textColor
        }
        Rectangle {
            id: content_user
            x: 185
            y: 82
            width: 200
            height: 50
            color: "#00000000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            clip: true
            ProfileRound {
                id: user_pp
                width: 50
                height: 50
                color: "#00ffffff"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 0
                borderIndicatorColor: header.color
                userImage: userPPImages
                indicator_on: controlsThemes.headerApp.profilRound.indicator_on
                indicator_off: controlsThemes.headerApp.profilRound.indicator_off
                MouseArea{
                    anchors.fill:parent
                    hoverEnabled:true
                    onClicked: {
                        internal_app.params_Shortcuts()
                    }
                }
            }
            Text {
                id: user_name
                x: 55
                width: 137
                height: 16
                color: controlsThemes.headerApp.textColor
                text: userProfile.prenom + " " + userProfile.nom
                anchors.verticalCenter: user_pp.verticalCenter
                font.pixelSize: 12
                anchors.verticalCenterOffset: -2
                font.bold: true
            }
            Text {
                id: user_level
                x: 55
                width: 97
                height: 14
                color: controlsThemes.headerApp.textColor
                text: profileComplement.filier + " " + userProfile.level
                anchors.verticalCenter: user_name.verticalCenter
                font.pixelSize: 10
                anchors.verticalCenterOffset: 14
            }
        }
        Rectangle {
            id: rectangle2
            x: 832
            width: 38
            height: 37
            color: "#00ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: content_user.left
            anchors.rightMargin: 20
            anchors.verticalCenterOffset: 1
            clip: false
            Rectangle{
                x: 16
                y: -5
                width: 22
                height: 12
                opacity: 1
                color: "#df000000"
                radius: 4
                border.width: 0
                anchors.right: parent.right
                anchors.bottom: parent.top
                anchors.rightMargin: 0
                anchors.bottomMargin: -3
            }
            Rectangle {
                id: notifContent
                width: 25
                height: 25
                color: controlsThemes.headerApp.notifContentColor
                radius: 5
                border.width: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                Image {
                    id: icons
                    width: 15
                    height: 15
                    anchors.verticalCenter: parent.verticalCenter
                    source: icons.bell || "../src/ico/bell.svg"
                    anchors.horizontalCenter: parent.horizontalCenter
                    clip: true
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
        Image {
            id: image
            x: 706
            y: 25
            width: 20
            height: 20
            anchors.right: rectangle2.left
            anchors.rightMargin: 20
            source: icons.calendar || "../src/ico/calandar.svg"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill:parent
                onClicked: {
                    loderDescription.source = "CustomCalandar.qml"
                    popContentherrr.open()
                }
            }
        }
    }
}