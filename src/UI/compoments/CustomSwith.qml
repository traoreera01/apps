import QtQuick 6.5
import QtQuick.Controls.Basic 2.15

/*
*/
Switch {
    id: root
    property color checkColor: "#0ACF97"
    property color roundColor: "#2f3844"
    property color  unchekColor: "#4e9788"
    property url darkImgUrl:  "../src/ico/moon.svg"
    property url lightImgUrl:  "../src/ico/sun.svg"
    checked: true

    indicator: Rectangle {
        id: rectangle1
        width: 40
        height: 20
        radius: height / 2
        color: root.checked ? root.checkColor : root.unchekColor
        border.width: 2
        border.color: root.checked ? checkColor : root.unchekColor
        Image {
            id: lightImg
            source: root.lightImgUrl
            anchors.leftMargin: 5
            width: 10
            height: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        Image {
            id: darckImg
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            width: 10
            height: 10
            source:root.darkImgUrl|| ""
            anchors.rightMargin: 3
        }

        Rectangle {
            id: rectangle
            x: root.checked ? parent.width - width - 0 : 1
            height: 20
            width: 20
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            color: root.roundColor
            border.color: root.checked ? checkColor : root.unchekColor

            Behavior on x {
                NumberAnimation {
                    easing.bezierCurve: [0.221,0.498,0.781,0.518,1,1]
                    duration: 250
                }
            }
        }
    }
}
