import QtQuick
import QtQuick.Controls
import "../compoments"

Rectangle{
    id: rectangle
    width: 500
    height: 366
    radius: 20
    color: "transparent"

    Text {
        id: text1
        x: 271
        y: 50
        width: 216
        height: 49
        color: "#ffffff"
        text: bookName
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        font.bold: true
    }

    Text {
        id: text2
        x: 271
        y: 115
        width: 216
        height: 111
        opacity: 0.875
        color: "#f9f9f9"
        text: bookdescription
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        clip: true
        font.bold: true
    }

    Custom {
        id: custom
        x: 377
        y: 310
        width: 110
        height: 40
        text: "Lire"
        onClicked: {
            todownload.OpenPdfFile()
        }
    }

    Rectangle {
        id: rectangle1
        width: 229
        color: "#00ffffff"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        clip: true

        Image {
            id: img
            visible: false
            anchors.fill: parent
            source:screenPdf
            fillMode: Image.Stretch
        }

        Item {
            id: mask
            visible: false
            anchors.fill: parent
            Rectangle {
                width: img.paintedWidth
                height: img.paintedHeight
                color: "#ffffff"
                radius: 20
                anchors.centerIn: parent
            }
            clip: true
        }

        OpacityMaskEffect {
            anchors.fill: parent
            source: img
            maskSource: mask
        }
    }
}
