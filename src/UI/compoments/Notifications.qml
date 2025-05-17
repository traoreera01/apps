import QtQuick 2.15
import QtQuick.Controls 2.15

import "../controls"
import "../pages"
// TODO: for other ..
Item {
    id: name
    implicitHeight: 210
    implicitWidth: 110
    property color dropColor: homes.notification.drop.dropColor
    property double dropRadius: homes.notification.drop.dropRadius
    property double dropSpread: homes.notification.drop.dropSpread
    property double dropVerticalOffset: homes.notification.drop.dropVerticalOffset
    property double dropHorizontalOffset: homes.notification.drop.dropHorizontalOffset
    property double dropsamples: homes.notification.drop.dropsamples
    property double notifRad: 10
    property color notifBgColor: homes.notification.drop.notificationBg

    Rectangle{
        id:content
        width: 110
        color: name.notifBgColor
        radius:name.notifRad
        border.color: "#00000000"
        border.width: 0
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 24
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        implicitHeight: 200
        implicitWidth: 90
    }

    TriangleItem{
        id:trigItms
        width: 20
        radius: 0
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 15
        anchors.bottomMargin: 185
        anchors.horizontalCenter: parent.horizontalCenter
        strokeWidth: 0
        joinStyle: 2
        strokeStyle: 0
        fillColor: name.notifBgColor
        strokeColor: name.notifBgColor
    }

    DropShadowEffect{
        x: 5
        y: 6
        color: name.dropColor
        radius: name.dropRadius
        anchors.fill: content
        source: content
        spread: 0.1
        samples: 12
        verticalOffset: 2
        horizontalOffset: 0
    }

    DropShadowEffect {
        x: 5
        y: 6
        color: name.dropColor
        radius: name.dropRadius
        anchors.fill: trigItms
        source: trigItms
        verticalOffset: name.dropVerticalOffset
        spread: name.dropSpread
        samples: name.dropsamples
        horizontalOffset: name.dropHorizontalOffset
    }
}
