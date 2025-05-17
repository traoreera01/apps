import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import "../effect" 


Rectangle{
    id:root
    width: 100
    height: 100
    
    radius: root.radius_mask
    border.width: 0
    property url userImage: userPPImages
    property bool preserveAspect: false
    property bool indicatorVisible: true

    property int radius_mask: 5
    property int indicatorWidth: 15
    property int indicatorHeight: 15
    property int indicatoRaduis: 8
    property color borderIndicatorColor: "#2f2f2f"
    property color indicator_on: "#5aee2c"
    property color indicator_off: "#c93131"
    Timer{
        interval: 900
        repeat: true
        running: true
        onTriggered:{
            homeContext.host_requesting()
            if(status_host){
                indicator.color = root.indicator_on
            }else{
                indicator.color = root.indicator_off
            }
        }
    }
    Rectangle {
        id: ppImg
        color: "#00ffffff"
        radius: 0
        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        border.width: 0
        Image {
            id: img1
            visible: false
            anchors.fill: parent
            source: root.userImage || ""
            fillMode: if (root.preserveAspect){
                return Image.PreserveAspectCrop
            }else {
                return Image.Stretch
            }
            
            clip: true
        }
        Item {
            id: mask1
            visible: false
            anchors.fill: parent
            Rectangle {
                color: "#fff"
                radius: root.radius_mask
                border.width: 0
                anchors.fill: parent
                clip: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
            clip: true
        }
        OpacityMaskEffect {
            anchors.fill: parent
            source: img1
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            maskSource: mask1
            clip: true
        }
        clip: true
    }
    Rectangle{
        id: rectangle
        color: "transparent"
        anchors.fill: parent
        Rectangle {
            id: indicator
            x: 8
            width: root.indicatorWidth
            height: root.indicatorHeight
            color: root.indicator_off
            radius:root.indicatoRaduis
            border.width: 3
            border.color: root.borderIndicatorColor
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.topMargin: 0
            clip: true
            visible: root.indicatorVisible
        }
    }
}
