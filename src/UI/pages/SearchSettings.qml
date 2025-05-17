import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import QtQuick.Pdf

Rectangle{
    id: bg
    width: 500
    height: 366
    radius: 0
    border.width: 0

    Rectangle {
        id: header
        width: 356
        height: 25
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        color: "#f9e9e8e6"
        radius: 5
        border.color: "#f9e9e8e6"

        Rectangle {
            id: category_btn
            width: 117
            height: 23
            opacity: 1
            color: "#ff9000"
            radius: 5
            border.width: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 1
            anchors.verticalCenterOffset: 0
            Label {
                id: read2
                text: "Filiere"
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                anchors.verticalCenterOffset: -0.3
                anchors.horizontalCenterOffset: -0.3
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea{
                x: 0
                y: 0
                anchors.fill: category_btn
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    category_btn.color = "#ff9000"
                    level_btn.color = "transparent"
                    years_btn.color = "transparent"
                }
            }
            clip: true
        }

        Rectangle {
            id: level_btn
            width: 117
            height: 23
            opacity: 1
            color: "#00000000"
            radius: 5
            border.width: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: category_btn.right
            anchors.leftMargin: 1
            Label {
                id: read3
                text: "Niveau"
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                styleColor: "#000000"
                font.bold: true
                anchors.verticalCenterOffset: -0.3
                anchors.horizontalCenterOffset: -0.3
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    category_btn.color = "transparent"
                    level_btn.color = "#ff9000"
                    years_btn.color = "transparent"
                }
            }
            clip: true
            anchors.verticalCenterOffset: 0
        }

        Rectangle {
            id: years_btn
            width: 117
            height: 23
            opacity: 1
            color: "#00020100"
            radius: 5
            border.width: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: level_btn.right
            anchors.leftMargin: 1
            Label {
                id: read4
                text: "Anee"
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                anchors.verticalCenterOffset: -0.3
                anchors.horizontalCenterOffset: -0.3
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                id: mouseArea1
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    category_btn.color = "transparent"
                    level_btn.color = "transparent"
                    years_btn.color = "#ff9000"
                }
            }
            clip: true
            anchors.verticalCenterOffset: 0
        }
    }
    Rectangle {
        id: body
        width: 410
        height: 290
        color: "#ffffff"
        anchors.top: header.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }
}