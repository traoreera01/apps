import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import "../compoments"
import "../effect"



Rectangle{
    id: root
    width: 900
    height: 500
    property string test_: "test is me "
    color: "#00000000"
    QtObject{
        id: profile_internal 
        function model_text_return(index){
            switch(index){
                case 0: return root.test_ = userProfile.nom
                case 1: return root.test_ = userProfile.prenom
                case 2: return root.test_ = profileComplement.dates
                case 3: return root.test_ = userProfile.email
                case 4: return root.test_ = userProfile.level
            }
        }
    }
    Rectangle {
        id: profile_
        y: 0
        width: 803
        height: 195
        color: "#00000000"
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        ProfileRound {
            id: user_profile
            x: 0
            width: 175
            height: 175
            color: params.profil.profilColor || "#005eff"
            anchors.verticalCenter: parent.verticalCenter
            borderIndicatorColor: params.profil.profilColor || "#005eff"
            indicatoRaduis: 20
            indicatorWidth: 34
            indicatorHeight: 34
            radius_mask: 100
            userImage: "https://thumbs.dreamstime.com/b/fermez-vous-vers-le-haut-du-jeune-homme-africain-beau-92170914.jpg"
            MouseArea{
                id: profile_change_
                anchors.fill:parent
                onClicked: {
                    dialog.open()
                }
            }
        }
        Text {
            id: user_name_
            width: 418
            height: 56
            text: qsTr(userProfile.prenom + " " + userProfile.nom)
            color: params.profil.textColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: user_profile.right
            anchors.leftMargin: 40
            font.letterSpacing: 0.5
            font.pixelSize: 45
            anchors.verticalCenterOffset: -24
            font.bold: true
        }
        Custom {
            id: custom
            width: 124
            height: 40
            text: "Photo de profil"
            anchors.top: user_name_.bottom
            anchors.topMargin: 22
            anchors.horizontalCenterOffset: -125
            anchors.horizontalCenter: parent.horizontalCenter
            
            // property color 
            hoverColor: controlsThemes.custom.hoverColor
            clikColor: controlsThemes.custom.clikColor
            indicatorColor: controlsThemes.custom.indicatorColor
            textColor: controlsThemes.custom.otherParams.textColor
            defaultColor: controlsThemes.custom.otherParams.defaultColor
            
            onClicked: dialog.open()
        }
        Custom {
            id: custom1
            width: 271
            height: 40
            text: "Modifier les informations personelles"
            anchors.top: user_name_.bottom
            anchors.topMargin: 22
            anchors.horizontalCenterOffset: 96
            anchors.horizontalCenter: parent.horizontalCenter
            hoverColor: controlsThemes.custom.hoverColor
            clikColor: controlsThemes.custom.clikColor
            indicatorColor: controlsThemes.custom.indicatorColor
            textColor: controlsThemes.custom.otherParams.textColor
            defaultColor: controlsThemes.custom.otherParams.defaultColor
        }
    }
    Column {
        id: column
        width: 857
        anchors.top: profile_.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 28
        anchors.bottomMargin: 33
        anchors.horizontalCenter: parent.horizontalCenter
        property string text_: ""
        Repeater{
            model: ListModel{
                ListElement { label: "Nom"; value: "SALAMBERE" }
                ListElement { label: "Prénom"; value: "Fahad Nouredine" }
                ListElement { label: "Date de naissance"; value: "12/12/2209" }
                ListElement { label: "Adresse mail"; value: "nouredinesalambere12@icloud.com" }
                ListElement { label: "Niveau"; value: "GMP Master 1" }
            }
            Rectangle {
                id: rectangle2
                x: 27
                y: 216
                width: parent.width -100
                height: 50
                color: "#00000000"
                Rectangle {
                    id: rectangle3
                    height: 2
                    opacity: 0.522
                    color: "gray"
                    border.color: "lightgray"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                }
                Text {
                    id: _text
                    text: model.label
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    font.pixelSize: 12
                    color: params.profil.textColor
                }
                Text {
                    id: _text1
                    x: 493
                    width: 360
                    height: 16
                    color: params.profil.textColor
                    text: profile_internal.model_text_return(model.index)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.QtRendering
                    fontSizeMode: Text.HorizontalFit
                }
            }
        }
    }
    FileDialog{
        id: dialog
        title: "Biblioapp - Modifier la photo de profil"
        currentFolder: "~/"
        nameFilters: ["Images (*.png *.jpg *.jpeg)"]
        onAccepted: {
            profileContext.changeUser_Image()
        }
    }
}