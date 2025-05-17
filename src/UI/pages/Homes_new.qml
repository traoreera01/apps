import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../compoments"
import "../effect"
Item {
    id: root
    width: if(parent.width === null) { return 1100 } else {return parent.width }
    height: if (parent.height === null) { return 700 } else {return parent.height }
    Rectangle{
        id:bg
        color: homes.bgColor || "#dee5f3"
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 1
        border.width: 0
        border.color: homes.bgColor || "#dee5f3"
        Rectangle {
            id: header
            x: 0
            y: 0
            width: parent.width
            height: 70.5
            color: "#00b38282"
            radius: 20
            clip: true
            HeaderApp{
                anchors.fill: parent
                searchBarVisible: false
            }
        }
        Rectangle {
            id: body
            color: homes.bgColor || "#dee5f3"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            Rectangle {
                id: top_content
                height: 240
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 0
                clip: true
                Rectangle {
                    id: card_content
                    x: -67
                    y: -96
                    width: 530
                    height: 202
                    color: homes.body.cartContentColor || "#fff"
                    radius: homes.body.cartContentRad || 16
                    border.width: 0
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 30
                    anchors.topMargin: 25
                    clip: true

                    Row {
                        id: card_row
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 15
                        anchors.rightMargin: 15
                        anchors.topMargin: 15
                        anchors.bottomMargin: 15
                        spacing: 10
                        Rectangle {
                            id: actuality_content2
                            width: 160
                            height: card_row.height
                            color: homes.body.card.color || "#005eff"
                            radius: homes.body.card.radius || 16
                            border.width: 0
                            anchors.leftMargin: 30
                            clip: true
                            Image {
                                id: pdt_Img
                                width:88
                                height: 88
                                anchors.top: parent.top
                                anchors.topMargin: 8
                                source: icons.pdf || "../src/ico/pdf.svg"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Label{
                                id: pdf_title
                                text:"Programmation pyside 6 et interface graphique"
                                anchors.bottom: pdt_Img.top
                                anchors.bottomMargin: -120
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                lineHeight: 0.9
                                color: homes.body.card.textColor || "#fff"
                                textFormat: Text.RichText
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 130
                            }
                            Rectangle {
                                id: separator_menu1
                                y: 141
                                width: 117
                                height: 23
                                opacity: 1
                                color:  homes.body.card.read.color || "#ff9000"
                                radius: homes.body.card.read.radius || 9
                                border.width: 0
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                anchors.horizontalCenter: parent.horizontalCenter
                                clip: true
                                Image {
                                    id: name
                                    x: 50
                                    y: 9
                                    source: icons.chevronRight || "../src/ico/chevron-right.svg"
                                    width: 10
                                    height: 10
                                    anchors.left: read1.right
                                    anchors.leftMargin: 0
                                }
                                Label{
                                    id:read1
                                    text:"Lire"
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.verticalCenterOffset: -0.3
                                    anchors.horizontalCenterOffset: -0.3
                                    font.bold: true
                                    color: homes.body.card.read.textColor || "#fff"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                        }

                        Rectangle {
                            id: actuality_content3
                            width: 160
                            height: card_row.height
                            color: homes.body.card.color || "#005eff"
                            radius: homes.body.card.radius || 16
                            border.width: 0
                            anchors.leftMargin: 30
                            Image {
                                id: pdt_Img1
                                width: 88
                                height: 88
                                anchors.top: parent.top
                                anchors.topMargin: 8
                                source: icons.pdf
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Label {
                                id: pdf_title1
                                width: 130
                                text: "Programmation pyside 6 et interface graphique"
                                anchors.bottom: pdt_Img1.top
                                anchors.bottomMargin: -120
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                lineHeight: 0.9
                                color: homes.body.card.textColor || "#fff"
                                textFormat: Text.RichText
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Rectangle {
                                id: separator_menu2
                                y: 141
                                width: 117
                                height: 23
                                opacity: 1
                                color:  homes.body.card.read.color || "#ff9000"
                                radius: 9
                                border.width: 0
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                Image {
                                    id: name1
                                    x: 50
                                    y: 9
                                    width: 10
                                    height: 10
                                    anchors.left: read2.right
                                    anchors.leftMargin: 0
                                    source: icons.chevronRight || "../src/ico/chevron-right.svg"
                                }

                                Label {
                                    id: read2
                                    text: "Lire"
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.bold: true
                                    color: homes.body.card.read.textColor || "#fff"
                                    anchors.verticalCenterOffset: -0.3
                                    anchors.horizontalCenterOffset: -0.3
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                clip: true
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            clip: true
                        }

                        Rectangle {
                            id: actuality_content4
                            width: 160
                            height: card_row.height
                            color: homes.body.card.color || "#005eff"
                            radius: 16
                            border.width: 0
                            anchors.leftMargin: 30
                            Image {
                                id: pdt_Img2
                                width: 88
                                height: 88
                                anchors.top: parent.top
                                anchors.topMargin: 8
                                source: icons.pdf
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Label {
                                id: pdf_title2
                                width: 130
                                text: "Programmation pyside 6 et interface graphique"
                                color: homes.body.card.textColor || "#fff"
                                anchors.bottom: pdt_Img2.top
                                anchors.bottomMargin: -120
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                lineHeight: 0.9
                                textFormat: Text.RichText
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Rectangle {
                                id: separator_menu3
                                y: 141
                                width: 117
                                height: 23
                                opacity: 1
                                color: homes.body.card.read.color || "#ff9000"
                                radius: 9
                                border.width: 0
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 10
                                Image {
                                    id: name2
                                    x: 50
                                    y: 9
                                    width: 10
                                    height: 10
                                    anchors.left: read3.right
                                    anchors.leftMargin: 0
                                    source: icons.chevronRight || "../src/ico/chevron-right.svg"
                                }

                                Label {
                                    id: read3
                                    text: "Lire"
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.bold: true
                                    color: homes.body.card.read.textColor || "#fff"
                                    anchors.verticalCenterOffset: -0.3
                                    anchors.horizontalCenterOffset: -0.3
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                                clip: true
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            clip: true
                        }
                        clip: true
                    }
                }
                Rectangle {
                    id: actuality_content
                    height: 200
                    color: homes.body.actuality.color
                    radius: 16
                    border.width: 0
                    width: 370  
                    anchors.left: card_content.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30
                    anchors.topMargin: 25
                    clip: true
                    Rectangle {
                        id: content_actuality
                        color: "transparent"
                        radius: 16
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 15
                        anchors.rightMargin: 15
                        anchors.topMargin: 15
                        anchors.bottomMargin: 15
                        SwipeView {
                            id: content_actuality_swip
                            anchors.fill: parent
                            clip: true
                            currentIndex: 0
                            orientation: Qt.Horizontal
                            background: Rectangle{
                                anchors.fill: parent
                                radius:content_actuality.radius
                                color: homes.body.actuality.swipBg

                            }
                            Page{
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: homes.body.actuality.pageColor
                                    radius: 16
                                    ImageRadius{
                                        anchors.fill:parent
                                        radius: 16
                                        source: images.page1
                                    }
                                }
                            }
                            Page{
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: homes.body.actuality.pageColor
                                    radius: 16
                                    ImageRadius{
                                        anchors.fill:parent
                                        radius: 16
                                        source: images.page2
                                    }
                                }
                            }
                            Page{
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: homes.body.actuality.pageColor
                                    radius: 16
                                    ImageRadius{
                                        anchors.fill:parent
                                        source: images.page3
                                        radius: 16
                                       
                                    }
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
                            id: row
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            spacing: 10
                            anchors.horizontalCenterOffset: 0
                            anchors.horizontalCenter: parent.horizontalCenter

                            Repeater {
                                anchors.verticalCenter: parent.verticalCenter
                                model: content_actuality_swip.count
                                Rectangle {
                                    id: widthControls
                                    width: if (content_actuality_swip.currentIndex === index){
                                               return 24
                                           }else{
                                               return 12
                                           }
                                    height: 12
                                    color: content_actuality_swip.currentIndex === index ? homes.swip.indicator.activate : homes.swip.indicator.deactivate
                                    radius: homes.swip.indicator.radius
                                    border.width: 0

                                }
                            }
                        }
                    }
                }

                DropShadowEffect{
                    anchors.fill: card_content
                    source: card_content
                    color: controlsThemes.dropEffect.colorEffect || "#4d241d1dd1d"
                    radius:controlsThemes.dropEffect.radius || 7
                    samples: controlsThemes.dropEffect.samples || 16
                    anchors.leftMargin: -.5
                    anchors.rightMargin:0
                    anchors.topMargin: 1
                    anchors.bottomMargin: -1
                    verticalOffset: 0
                    horizontalOffset: 0
                    clip: false
                }

                DropShadowEffect {
                    color: controlsThemes.dropEffect.colorEffect || "#4d241d1dd1d"
                    radius:controlsThemes.dropEffect.radius || 7
                    samples: controlsThemes.dropEffect.samples || 16
                    anchors.leftMargin: -.5
                    anchors.rightMargin:0
                    anchors.topMargin: -1
                    anchors.bottomMargin: -1

                    source: actuality_content
                    anchors.fill: actuality_content
                    verticalOffset: 0
                    horizontalOffset: 0
                    clip: false
                }
            }

            Rectangle {
                id: calandar_
                color: homes.body.calandar.color
                radius: homes.body.calandar.radius
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: top_content.bottom
                anchors.bottom: parent.bottom
                anchors.leftMargin: 30
                anchors.rightMargin: 30
                anchors.topMargin: 10
                anchors.bottomMargin: 25
                clip: true
                Table{
                    headerModel: [
                        {text: 'Horaires', width: 0.2},
                        {text: 'Lundi', width: 0.1},
                        {text: 'Mardi', width: 0.1},
                        {text: 'Mercredi', width: 0.199},
                        {text: 'Jeudi', width: 0.1},
                        {text: 'Vendredi', width: 0.1},
                        {text: 'Samedi', width: 0.1},
                        {text: 'Dimanche', width: 0.1}
                    ]
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10

                    headerColor: controlsThemes.table.headerColor || "#f8f8f8"
                    textColor: controlsThemes.table.textColor || "#5a5a5a"
                    headerCeparatorColor: controlsThemes.table.headerCeparatorColor || "#e0e0e0"
                    bodyContentColor1: controlsThemes.table.bodyContentColor1 || "#fff"
                    bodyContentColor2: controlsThemes.table.bodyContentColor2 || "#fff"
                    bodyTextColor: controlsThemes.table.bodyTextColor || "#4a4a4a"
                    scrollIndicatorColor: controlsThemes.table.scrollIndicatorColor || "#a0a0a0"
                    scrollBackColor: controlsThemes.table.scrollBackColor || "#e0e0e0"

                }
            }
            DropShadowEffect {
                color: controlsThemes.dropEffect.colorEffect || "#4d241d1dd1d"
                radius:controlsThemes.dropEffect.radius || 7
                samples: controlsThemes.dropEffect.samples || 16
                anchors.fill: calandar_
                anchors.leftMargin: -1
                anchors.rightMargin: -1
                anchors.topMargin: -1
                anchors.bottomMargin: -1
                source: calandar_
                verticalOffset: 0
                horizontalOffset: 0
                clip: false
            }
        }
    }
}