import QtQuick 6.5
import QtQuick.Controls.Basic 2.15

Button{
    id: btnTopBar
    property color colorDefaut: '#1c1d20'
    property color colorClik: '#00a1f1'
    property color colorMouse: '#23272E'
    property url   bticonSource: "images/minus.svg"
    property int raduisIs : 10
    QtObject{
        id: internal
        property var dynamicColor: if(btnTopBar.down){
                                      btnTopBar.down ? btnTopBar.colorClik : btnTopBar.colorDefaut
                                   } else{
                                       btnTopBar.hovered ? btnTopBar.colorMouse : btnTopBar.colorDefaut
                                   }
    }

    property var startAnimation_icon: if (btnTopBar.down){
        btnTopBar.down ? internal_.start_normal_Animation_icons() : internal_.start_reverse_animation_icons()
    }else{
        btnTopBar.hovered ? internal_.hoveread_() : internal_.hoveread_()
    }


    QtObject{
        id:internal_
        function start_normal_Animation_icons(){
            iconAnimation.from = 20
            iconAnimation.to = 10
            iconAnimation.running = true

            internal_.start_reverse_animation_icons()
        }
        function start_reverse_animation_icons(){
            iconAnimation.from = 10
            iconAnimation.to = 20
            iconAnimation.running = true
        }
        function hoveread_(){
           toggleImg.width = 20
        }
    }


    PropertyAnimation{
        id: iconAnimation
        target: toggleImg
        easing.bezierCurve: [0.445,0.05,0.55,0.95,1,1]
        properties: "width"
        duration:100
    }


    width: 35
    height: 33
    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor
        radius: btnTopBar.raduisIs
    }
    Image {
            id: toggleImg
            width: 15
            height:15
            anchors.verticalCenter: parent.verticalCenter
            source: btnTopBar.bticonSource || ""
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            antialiasing: false
        }
    }