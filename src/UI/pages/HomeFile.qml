import QtQuick 2.15
import QtQuick.Controls 6.5
import QtQuick.Window
import "../compoments"
import "../effect"


Rectangle {
id: bg
    width: if(parent.width === null) { return 1100 } else {return parent.width }
    height: if (parent.height === null) { return 700 } else {return parent.height }
    color: "#ffffff"



    Rectangle {
        id: background
        color: "#a6a6a6"
        anchors.fill: parent
        clip: true
        Image {
            anchors.fill: parent
            source: "../src/images/bgImg.png"
            fillMode: Image.PreserveAspectCrop
        }
    }
    Rectangle {
        id: glassEffect
        color: "#00000000"
        radius: 15
        border.color: "#ffffff"
        border.width: 2
        anchors.fill: parent
        clip: true
        ShaderEffectSource {
            id: shaderEffectSource
            width: glassEffect.width
            height: glassEffect.height
            sourceItem: background
            smooth: true
            live: false
            FastBlurEffect {
                radius: 29
                anchors.fill: parent
                source: shaderEffectSource
            }
        }

        Rectangle {
            opacity: 0.1
            color: "#ffffff"
            radius: 15
            anchors.fill: parent
        }

        Rectangle {
            id: rst
            width: 1024
            height: 616
            color: "#00ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            PropertyAnimation {
                id: widhControl
                target: parent
                property: "width"
                running: true
                easing.bezierCurve: [0.109,0.741,0.781,0.498,1,1]
                duration: 1000
            }

            Rectangle {
                id: rectangle
                x: 38
                y: 135
                color: "#00000000"
                anchors.fill: parent
                Rectangle {
                    id: header
                    width: 200
                    height: 112
                    color: "#ffffff"
                    radius: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30
                    anchors.topMargin: 30
                    Text {
                        id: text1
                        text: qsTr("BiBLIOapp")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        font.pixelSize: 20
                        font.bold: true
                        clip: true
                    }

                    Row {
                        id: row
                        x: 317
                        width: 226
                        height: header.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        spacing: 5
                        Column {
                            id: column
                            width: 120
                            height: 35
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 5
                            Text {
                                id: text2
                                text: qsTr("Bienvenu Fahad")
                                font.pixelSize: 15
                                font.bold: true
                                clip: true
                            }

                            Text {
                                id: text3
                                width: 107
                                text: qsTr("3eme annee Mi")
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignRight
                                clip: true
                            }
                            clip: true
                        }

                        Rectangle {
                            id: ppImg
                            width: 100
                            height: 100
                            color: "#00ffffff"
                            radius: 49
                            border.width: 2
                            anchors.verticalCenter: parent.verticalCenter
                            Image {
                                id: img1
                                visible: false
                                anchors.fill: parent
                                source: "../src/images/onedark-bash.png"
                                fillMode: Image.Stretch
                                clip: true
                            }

                            Item {
                                id: mask1
                                visible: false
                                anchors.fill: parent
                                Rectangle {
                                    id: maskrec
                                    color: "#ffffff"
                                    radius: 50
                                    anchors.fill: parent
                                    clip: true
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                clip: true
                            }

                            OpacityMaskEffect {
                                anchors.fill: parent
                                source: img1
                                maskSource: mask1
                                clip: true
                            }
                            clip: true
                        }
                        clip: true
                        anchors.verticalCenterOffset: 0
                    }
                    clip: true
                }

                Rectangle {
                    id: body
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: header.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 30
                    anchors.topMargin: 12
                    Rectangle {
                        id: rectangle1
                        width: 538
                        height: 270
                        opacity: 1
                        color: "#ffffff"
                        radius: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.rightMargin: 6
                        SwipeView {
                            id: swipeView
                            width: 523
                            height: 254
                            anchors.verticalCenter: parent.verticalCenter
                            orientation: Qt.Vertical
                            currentIndex: 0
                            Page {
                                id: page1
                                clip: true
                                Rectangle {
                                    id: rectangle6
                                    visible: true
                                    color: "#fff"
                                    anchors.fill: parent
                                    focus: true
                                    Image {
                                        id: img3
                                        visible: false
                                        anchors.fill: parent
                                        source: "../src/images/onedark-keyboard.jpg"
                                        fillMode: Image.Stretch
                                        clip: true
                                    }

                                    Item {
                                        id: mask3
                                        visible: false
                                        anchors.fill: parent
                                        Rectangle {
                                            width: img3.paintedWidth
                                            height: img3.paintedHeight
                                            color: "#ffffff"
                                            radius: 20
                                            anchors.centerIn: parent
                                        }
                                        clip: true
                                    }

                                    OpacityMaskEffect {
                                        opacity: 1
                                        anchors.fill: parent
                                        source: img3
                                        maskSource: mask3
                                        focus: true
                                        clip: true
                                    }
                                    clip: true
                                }
                            }

                            Page {
                                clip: true
                                Rectangle {
                                    id: rectangle11
                                    x: 0
                                    y: 0
                                    visible: true
                                    color: "#fff"
                                    anchors.fill: parent
                                    focus: true
                                    Image {
                                        id: img6
                                        visible: false
                                        anchors.fill: parent
                                        source: "../src/images/onedark-keyboard.jpg"
                                        fillMode: Image.Stretch
                                        clip: true
                                    }

                                    Item {
                                        id: mask6
                                        visible: false
                                        anchors.fill: parent
                                        Rectangle {
                                            width: img6.paintedWidth
                                            height: img6.paintedHeight
                                            color: "#ffffff"
                                            radius: 20
                                            anchors.centerIn: parent
                                        }
                                        clip: true
                                    }

                                    OpacityMaskEffect {
                                        opacity: 1
                                        anchors.fill: parent
                                        source: img6
                                        maskSource: mask6
                                        focus: true
                                        clip: true
                                    }
                                    clip: true
                                }
                            }

                            Page {
                                clip: true
                                Rectangle {
                                    id: rectangle12
                                    x: 0
                                    y: 0
                                    visible: true
                                    color: "#00ffffff"
                                    anchors.fill: parent
                                    focus: true
                                    Image {
                                        id: img7
                                        visible: false
                                        anchors.fill: parent
                                        source: "../src/images/onedark-keyboard.jpg"
                                        fillMode: Image.Stretch
                                        clip: true
                                    }

                                    Item {
                                        id: mask7
                                        visible: false
                                        anchors.fill: parent
                                        Rectangle {
                                            width: img7.paintedWidth
                                            height: img7.paintedHeight
                                            color: "#ffffff"
                                            radius: 20
                                            anchors.centerIn: parent
                                        }
                                        clip: true
                                    }

                                    OpacityMaskEffect {
                                        opacity: 1
                                        anchors.fill: parent
                                        source: img7
                                        maskSource: mask7
                                        focus: true
                                        clip: true
                                    }
                                    clip: true
                                }
                            }
                            clip: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Timer {
                            running: true
                            repeat: true
                            onTriggered: {
                                swipeView.currentIndex = (swipeView.currentIndex + 1) % swipeView.count


                            }
                            interval: 3000
                        }

                        Row {
                            x: 439
                            y: 250
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            spacing: 10
                            Repeater {
                                model: swipeView.count
                                Rectangle {
                                    width: if (swipeView.currentIndex === index){
                                               widhControl.from = 12
                                               widhControl.to = 24
                                           }else{
                                               return  12
                                           }
                                    height: 12
                                    color: swipeView.currentIndex === index ? "#ff4081" : "#c0c0c0"
                                    radius: 6
                                    border.color: "#ff4081"
                                    border.width: 1

                                }
                            }
                            anchors.horizontalCenterOffset: 0
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        clip: true
                    }

                    Rectangle {
                        id: rectangle8
                        width: 262
                        height: 172
                        opacity: 1
                        color: "#2f2f2f"
                        radius: 20
                        anchors.left: parent.left
                        anchors.top: rectangle1.bottom
                        anchors.leftMargin: 30
                        anchors.topMargin: 15
                        rotation: 0
                        Rectangle {
                            id: rectangle4
                            color: "#ffffff"
                            radius: 20
                            anchors.fill: parent
                            anchors.bottomMargin: 45
                            DropShadowEffect {
                                x: -152
                                y: -58
                                color: "#26000000"
                                radius: 9
                                anchors.fill: rectangle7
                                anchors.leftMargin: -1
                                anchors.rightMargin: -1
                                anchors.topMargin: -1
                                anchors.bottomMargin: -1
                                source: rectangle7
                                verticalOffset: 0
                                samples: 12
                                horizontalOffset: 0
                                clip: false
                            }

                            Rectangle {
                                id: rectangle7
                                x: -132
                                y: -22
                                width: 100
                                height: 100
                                visible: true
                                color: "#00ffffff"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                focus: true
                                Image {
                                    id: img4
                                    visible: false
                                    anchors.fill: parent
                                    source: "../src/images/onedark-bash.png"
                                    fillMode: Image.Stretch
                                    clip: true
                                }

                                Item {
                                    id: mask4
                                    visible: false
                                    anchors.fill: parent
                                    Rectangle {
                                        width: img4.paintedWidth
                                        height: img4.paintedHeight
                                        color: "#ffffff"
                                        radius: 20
                                        anchors.centerIn: parent
                                    }
                                    clip: true
                                }

                                OpacityMaskEffect {
                                    anchors.fill: parent
                                    source: img4
                                    maskSource: mask4
                                    focus: true
                                }
                                clip: true
                            }
                            clip: true
                        }
                        clip: false
                    }

                    Rectangle {
                        id: rectangle9
                        height: 172
                        opacity: 1
                        color: "#2f2f2f"
                        radius: 20
                        anchors.left: rectangle8.right
                        anchors.right: rectangle2.left
                        anchors.top: rectangle1.bottom
                        anchors.leftMargin: 14
                        anchors.rightMargin: 19
                        anchors.topMargin: 15
                        rotation: 0
                        Rectangle {
                            id: rectangle5
                            color: "#ffffff"
                            radius: 20
                            anchors.fill: parent
                            anchors.bottomMargin: 45
                            DropShadowEffect {
                                x: -152
                                y: -58
                                color: "#26000000"
                                radius: 9
                                anchors.fill: rectangle10
                                anchors.leftMargin: -1
                                anchors.rightMargin: -1
                                anchors.topMargin: -1
                                anchors.bottomMargin: -1
                                source: rectangle10
                                verticalOffset: 0
                                samples: 12
                                horizontalOffset: 0
                                clip: false
                            }

                            Rectangle {
                                id: rectangle10
                                x: -132
                                y: -22
                                width: 100
                                height: 100
                                visible: true
                                color: "#00ffffff"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                focus: true
                                Image {
                                    id: img5
                                    visible: false
                                    anchors.fill: parent
                                    source: "../src/images/onedark-bash.png"
                                    fillMode: Image.Stretch
                                    clip: true
                                }

                                Item {
                                    id: mask5
                                    visible: false
                                    anchors.fill: parent
                                    Rectangle {
                                        width: img5.paintedWidth
                                        height: img5.paintedHeight
                                        color: "#ffffff"
                                        radius: 20
                                        anchors.centerIn: parent
                                    }
                                    clip: true
                                }

                                OpacityMaskEffect {
                                    anchors.fill: parent
                                    source: img5
                                    maskSource: mask5
                                    focus: true
                                }
                                clip: true
                            }
                            clip: true
                        }
                        clip: false
                    }

                    Rectangle {
                        id: rectangle2
                        opacity: 0.653
                        color: "#000000"
                        radius: 20
                        anchors.left: rectangle1.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 19
                        anchors.rightMargin: 0
                        anchors.topMargin: 0
                        anchors.bottomMargin: 8
                        scale: 1
                        clip: true
                    }
                    clip: true
                }
                clip: true
            }
        }
        anchors.horizontalCenter: parent.horizontalCenter
    }
    }
