import QtQuick 2.15
import QtQuick.Controls 2.15

Popup{
    id: popup
    clip: true
    dim: true
    modal: true
    property color bgColor : homes.bgColor
    background: Rectangle{
        id: bg
        width: parent.width
        height: parent.height
        radius: 20
        color: popup.bgColor
        border.width: popup.bgColor
        border.color: popup.bgColor
    }
}
