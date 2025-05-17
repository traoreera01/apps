import QtQuick 2.15
import QtQuick.Controls.Basic 2.15



ComboBox {
    id: root
    implicitHeight: 50
    implicitWidth: 160
    property color textColor:"#ffffff"
    property color bgColor: "#597aff"
    property var mylist: ["Option 1", "Option 2", "Option 3"]
    property string textDisplay: "Custom combobox"

    background: Rectangle {
        anchors.fill: parent
        color: root.bgColor
        radius: 20
        border.color: "#00000000"
        border.width: 0
    }
    model: filier.mylist
    displayText: ""
    currentIndex: 0

    contentItem: Text {
        id: name
        height: 19
        color: root.textColor
        text: root.textDisplay
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenterOffset: -15
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
    }
    
    
    onCurrentIndexChanged: {
        name.text = root.mylist[root.currentIndex]
    }
}
