import QtQuick
import QtQuick.Controls
import "../compoments"
import "../effect"

//import QtQuick.Studio.Effects

Item {
    id: home
    width: if(parent.width === null) { return 1100 } else {return parent.width }
    height: if (parent.height === null) { return 700 } else {return parent.height }


    QtObject{
        id: internal_categories_choses
        function corrections_categories_cliked(){
            corrections_categories.textColor = controlsThemes.custom.textCliked
            corrections_categories.defaultColor = controlsThemes.custom.clikColor
            
            all_categories.textColor = controlsThemes.custom.textColor
            all_categories.defaultColor = controlsThemes.custom.defaultColor
            
            lecons_categories.textColor = controlsThemes.custom.textColor
            lecons_categories.defaultColor = controlsThemes.custom.defaultColor
            
            exercises_categories.textColor = controlsThemes.custom.textColor
            exercises_categories.defaultColor = controlsThemes.custom.defaultColor
        }
        function all_categories_cliked(){
            corrections_categories.textColor = controlsThemes.custom.textColor
            corrections_categories.defaultColor = controlsThemes.custom.defaultColor
            
            all_categories.textColor = controlsThemes.custom.textCliked
            all_categories.defaultColor = controlsThemes.custom.clikColor
            
            lecons_categories.textColor = controlsThemes.custom.textColor
            lecons_categories.defaultColor = controlsThemes.custom.defaultColor
            
            exercises_categories.textColor = controlsThemes.custom.textColor
            exercises_categories.defaultColor = controlsThemes.custom.defaultColor
        }
        function lecons_categories_cliked(){
            corrections_categories.textColor = controlsThemes.custom.textColor
            corrections_categories.defaultColor = controlsThemes.custom.defaultColor
            
            all_categories.textColor = controlsThemes.custom.textColor
            all_categories.defaultColor = controlsThemes.custom.defaultColor
            
            lecons_categories.textColor = controlsThemes.custom.textCliked
            lecons_categories.defaultColor = controlsThemes.custom.clikColor
            
            exercises_categories.textColor = controlsThemes.custom.textColor
            exercises_categories.defaultColor = controlsThemes.custom.defaultColor
        }
        function exercises_categories_cliked(){
            corrections_categories.textColor = controlsThemes.custom.textColor
            corrections_categories.defaultColor = controlsThemes.custom.defaultColor
            
            all_categories.textColor = controlsThemes.custom.textColor
            all_categories.defaultColor = controlsThemes.custom.defaultColor
            
            lecons_categories.textColor = controlsThemes.custom.textColor
            lecons_categories.defaultColor = controlsThemes.custom.defaultColor
            
            exercises_categories.textColor = controlsThemes.custom.textCliked
            exercises_categories.defaultColor = controlsThemes.custom.clikColor
        }
    }

    ColorAnimation {
        id: contentListAnim
        target: book_content
        property: "color"
        duration: bibliotheque.animations.duration || 1
        easing.bezierCurve: bibliotheque.animations.easing || [0.445, 0.05, 0.55, 0.95, 1, 1]
    }
    Rectangle {
        id: content
        color: bibliotheque.color || "#f9f7f9fb"
        border.width: 0
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        clip: true
        Rectangle {
            id: header
            x: 0
            y: 0
            width: parent.width
            height: 150
            color: "transparent"
            radius: 20
            clip: true
            HeaderApp{
                anchors.fill: parent
            }
        }

        Rectangle {
            id: result
            height: 49
            color: bibliotheque.topBarColor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: -76

            Label {
                id: search_result
                width: 235
                height: 24
                color: bibliotheque.textColor
                text: qsTr("Resultat:1000")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 59
                font.pixelSize: 15
                horizontalAlignment: Text.AlignLeft
            }

            Row {
                id: row
                y: 5
                width: 417
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15
                Custom {
                    id: all_categories
                    width: 90
                    text: "Tous"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked:internal_categories_choses.all_categories_cliked()
                }

                Custom {
                    id: lecons_categories
                    width: 90
                    text: "cours"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked:internal_categories_choses.lecons_categories_cliked()
                }

                Custom {
                    id: exercises_categories
                    width: 100
                    text: "Exercices"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked:internal_categories_choses.exercises_categories_cliked()
                }

                Custom {
                    id: corrections_categories
                    width: 90
                    text: "Corriges"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked:internal_categories_choses.corrections_categories_cliked()
                }
                clip: true
            }
            Label {
                id: filter_by
                x: 786
                width: 188
                height: 25
                color:bibliotheque.textColor
                text: qsTr("Filtre par: les plus recents")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 60
                font.pixelSize: 15
                horizontalAlignment: Text.AlignRight
            }
        }
        Rectangle {
            id: book_content
            color: bibliotheque.bookContentColor
            radius: 20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: result.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 24
            anchors.rightMargin: 15
            anchors.topMargin: 10
            anchors.bottomMargin: 23
            clip: true
            Table {
                id: listContent
                headerModel: [ 
                    {text: 'Nom', width: 0.4},
                    {text: 'Taille', width: 0.1},
                    {text: 'Type', width: 0.1},
                    {text: 'Date', width: 0.2}, 
                    {text: 'test', width: 0.1}
                ]
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                clip: true
                dataModel: [
                    ["programmation oriente objet", '900KB', 'Ebook', '2002-02-02', 'test!',],
                    ["programmation oriente objet", '900KB', 'Ebook', '2002-02-02', 'test!',],
                    ["programmation oriente objet", '900KB', 'Ebook', '2002-02-02', 'test!',],
                    ["programmation oriente objet", '900KB', 'Ebook', '2002-02-02', 'test!',],
                ]
                headerColor: controlsThemes.table.headerColor || "#f8f8f8"
                textColor: controlsThemes.table.textColor || "#5a5a5a"
                headerCeparatorColor: controlsThemes.table.headerCeparatorColor || "#e0e0e0"
                bodyContentColor1: controlsThemes.table.bodyContentColor1 || "#fff"
                bodyContentColor2: controlsThemes.table.bodyContentColor2 || "#fff"
                bodyTextColor: controlsThemes.table.bodyTextColor || "#4a4a4a"
                scrollIndicatorColor: controlsThemes.table.scrollIndicatorColor || "#a0a0a0"
                scrollBackColor: controlsThemes.table.scrollBackColor || "#e0e0e0"
                //onClicked: console.log(dataModel[index])
            }
        }
        DropShadowEffect{
            anchors.fill: book_content
            source: book_content
            color: controlsThemes.dropEffect.colorEffect || "#4d241d1dd1d"
            radius:controlsThemes.dropEffect.radius || 7
            samples: controlsThemes.dropEffect.samples || 16
            anchors.leftMargin: -1
            anchors.rightMargin: -1
            anchors.topMargin: -1
            anchors.bottomMargin: -1
            verticalOffset: 0
            horizontalOffset: 0
            clip: false
            opacity: 0.1
        }
    }
}