import QtQuick
import QtQuick.Controls.Basic
import "../compoments"

Window {
    id: root
    width: 1000
    height: 610
    visible: true
    color: "#00000000"
    x: (Screen.width - width) /2
    y: (Screen.height - height)/2
    //flags: Qt.Window | Qt.FramelessWindowHint
    Rectangle {
        id: rectangle1
        color: "#015eff"
        radius: 20
        border.width: 0
        anchors.fill: parent
        clip: true
        opacity: 1
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#015eff"}
            GradientStop { position: 1.0; color: "#155cd5" }
        }
        Rectangle {
            id: rectangle
            x: 10
            y: 10
            width: 500
            color: "transparent"//homes.body.actuality.pageColor
            radius: 20
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            clip: true
            SwipeView {
                id: content_actuality_swip
                anchors.fill: parent
                clip: true
                currentIndex: 0
                orientation: Qt.Vertical
                background: Rectangle{
                    anchors.fill: parent
                    radius:rectangle.radius
                    border.width: 0
                    color: "transparent"//homes.body.actuality.pageColor
                    ImageRadius{
                        anchors.fill:parent
                        source: images.onedark_bash
                        radius: 10
                    }
                }
                Page{
                    background: Rectangle{
                        anchors.fill: parent
                        color: "transparent"//homes.body.actuality.pageColor
                        radius: 10
                        border.width: 0
                    }
                }
                Page{
                    background: Rectangle{
                        anchors.fill: parent
                        color: "transparent"//homes.body.actuality.pageColor homes.body.actuality.pageColor
                        radius: 10
                        border.width: 0
                    }
                }
                Page{
                    background: Rectangle{
                        anchors.fill: parent
                        color: "red"//homes.body.actuality.pageColor
                        radius: 10
                        border.width: 0
                    }
                }
                Timer{
                    triggeredOnStart: true
                    running: true
                    repeat: true
                    interval: 9000
                    onTriggered: {
                        content_actuality_swip.currentIndex = (content_actuality_swip.currentIndex + 1) % content_actuality_swip.count
                    }
                }
            }
            Row {
                id: row_
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                spacing: 10
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater {
                    anchors.verticalCenter: parent.verticalCenter
                    model: content_actuality_swip.count
                    Rectangle {
                        id: widthControls
                        width: 24
                        height: 5
                        color: content_actuality_swip.currentIndex === index ? homes.swip.indicator.activate : homes.swip.indicator.deactivate
                        radius: homes.swip.indicator.radius
                        border.width: 0
                    }
                }
            }
        }

        Rectangle {
            id: rectangle2
            x: 572
            width: 435
            color: "#00ffffff"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10

            Column {
                id: titleContent
                y: 74
                width: 378
                height: 105
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                spacing: 20

                Label {
                    id: label
                    width: titleContent.width
                    color: "#ede0e0"
                    text: qsTr("Se Connecte")
                    font.pointSize: 25
                    font.bold: true
                }

                Row {
                    id: row
                    width: titleContent.width
                    height: 20
                    spacing: 10
                    Label {
                        id: label1
                        color: "#ede0e0"
                        text: qsTr("Avez vous ps un compte ?")
                        font.pointSize: 10
                        font.bold: true
                    }
                    Label {
                        id: label2
                        x: 0
                        color: "#cbd434"
                        text: qsTr("cree en.")
                        font.underline: true
                        font.pointSize: 10
                        font.bold: true
                        MouseArea{
                            anchors.fill:parent
                            onClicked:{
                                newCompte.create_account()
                            }
                        }
                    }
                }
            }
            Column {
                id: content
                y: 230
                width: 378
                height: 323
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                CustomTextField {
                    id: username
                    radius: 5
                    width: parent.width
                    amimationRun: false
                    controlsHover: false
                    placeholderText: "username or email"
                }
                PasswordCustom {
                    id: password
                    width: parent.width
                    amimationRun: false
                    hoverEnabled: false
                    radius: 5
                    placeholderText: "password"
                }
                Row {
                    id: row2
                    width: 200
                    height: 20
                    CheckBox {
                        id: checkBox_
                        y: 0
                        width: 20
                        height: 21
                        indicator: Rectangle {
                            id: indicatorRec
                            width: 20
                            height: 20
                            color: checkBox_.checked ? "#39ff00" : "#ffffff"
                            radius: 5
                        }
                        clip: true
                        //checked: false
                    }
                    Text{
                        height: 20
                        color: "#ffffff"
                        text: "  J'accepte les"
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {
                        height: 20
                        color: "#c6d138"
                        text: "  conditions d'utilisations"
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    id: rectangle3
                    width: custom.width
                    height: 20
                    color: "#00ffffff"
                }
                Custom {
                    id: custom
                    width: content.width
                    text: "Connexion"
                    textColor: "#ffffff"
                    defaultColor: "#ff7701"
                    onClicked: login.logins(username.text, password.text, checkBox_.checked)
                }
            }
        }
    }
}
