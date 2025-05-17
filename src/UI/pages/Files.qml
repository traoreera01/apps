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
        id: internal_categories_choses_files
        function corrections_categories_cliked(){
            files_corrections_categories.textColor = controlsThemes.custom.textCliked
            files_corrections_categories.defaultColor = controlsThemes.custom.clikColor
            files_all_categories.textColor = controlsThemes.custom.textColor
            files_all_categories.defaultColor = controlsThemes.custom.defaultColor
            files_lecons_categories.textColor = controlsThemes.custom.textColor
            files_lecons_categories.defaultColor = controlsThemes.custom.defaultColor
            files_exercises_categories.textColor = controlsThemes.custom.textColor
            files_exercises_categories.defaultColor = controlsThemes.custom.defaultColor
        }
        function all_categories_cliked(){
            files_corrections_categories.textColor = controlsThemes.custom.textColor
            files_corrections_categories.defaultColor = controlsThemes.custom.defaultColor
            files_all_categories.textColor = controlsThemes.custom.textCliked
            files_all_categories.defaultColor = controlsThemes.custom.clikColor
            files_lecons_categories.textColor = controlsThemes.custom.textColor
            files_lecons_categories.defaultColor = controlsThemes.custom.defaultColor
            files_exercises_categories.textColor = controlsThemes.custom.textColor
            files_exercises_categories.defaultColor = controlsThemes.custom.defaultColor
        }
        function lecons_categories_cliked(){
            files_corrections_categories.textColor = controlsThemes.custom.textColor
            files_corrections_categories.defaultColor = controlsThemes.custom.defaultColor
            files_all_categories.textColor = controlsThemes.custom.textColor
            files_all_categories.defaultColor = controlsThemes.custom.defaultColor
            files_lecons_categories.textColor = controlsThemes.custom.textCliked
            files_lecons_categories.defaultColor = controlsThemes.custom.clikColor
            files_exercises_categories.textColor = controlsThemes.custom.textColor
            files_exercises_categories.defaultColor = controlsThemes.custom.defaultColor
        }
        function exercises_categories_cliked(){
            files_corrections_categories.textColor = controlsThemes.custom.textColor
            files_corrections_categories.defaultColor = controlsThemes.custom.defaultColor
            files_all_categories.textColor = controlsThemes.custom.textColor
            files_all_categories.defaultColor = controlsThemes.custom.defaultColor
            files_lecons_categories.textColor = controlsThemes.custom.textColor
            files_lecons_categories.defaultColor = controlsThemes.custom.defaultColor
            files_exercises_categories.textColor = controlsThemes.custom.textCliked
            files_exercises_categories.defaultColor = controlsThemes.custom.clikColor
        }
    }
    ColorAnimation {
        id: contentListAnim
        target: book_content
        property: "color"
        duration: 1
        easing.bezierCurve: [0.445, 0.05, 0.55, 0.95, 1, 1]
    }
    ColorAnimation {
        id: listContentAim
        target: book_content
        property: "color"
        duration: 1300
        easing.bezierCurve: [0.445, 0.05, 0.55, 0.95, 1, 1]
        running: true
    }
    Rectangle {
        id: content
        color:bibliotheque.color
        //radius: 20
        border.color: "#00000000"
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
            color:bibliotheque.topBarColor
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
                color:bibliotheque.textColor
                text: qsTr("Telecharge:100")
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
                    id: files_all_categories
                    width: 90
                    text: "Tous"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked:internal_categories_choses_files.all_categories_cliked()
                }
                Custom {
                    id: files_lecons_categories
                    width: 90
                    text: "cours"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked: internal_categories_choses_files.lecons_categories_cliked()
                }
                Custom {
                    id: files_exercises_categories
                    width: 100
                    text: "Exercices"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked: internal_categories_choses_files.exercises_categories_cliked()
                }
                Custom {
                    id: files_corrections_categories
                    width: 90
                    text: "Corriges"
                    hoverColor: controlsThemes.custom.hoverColor
                    clikColor: controlsThemes.custom.clikColor
                    indicatorColor: controlsThemes.custom.indicatorColor
                    textColor: controlsThemes.custom.textColor
                    defaultColor: controlsThemes.custom.defaultColor
                    onClicked: internal_categories_choses_files.corrections_categories_cliked()
                }
                clip: true
            }
            Label {
                id: filter_by
                x: 786
                width: 188
                height: 25
                color: bibliotheque.textColor
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
                headerModel: [ 
                    {text: 'Nom', width: 0.4},
                    {text: 'Taille', width: 0.1},
                    {text: 'Type', width: 0.1},
                    {text: 'Date', width: 0.2}, 
                    {text: 'test', width: 0.1}
                ]
                id: listContent
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                clip: true
                onClicked: print(dataModel[index])
                headerColor: controlsThemes.table.headerColor || "#f8f8f8"
                textColor: controlsThemes.table.textColor || "#5a5a5a"
                headerCeparatorColor: controlsThemes.table.headerCeparatorColor || "#e0e0e0"
                bodyContentColor1: controlsThemes.table.bodyContentColor1 || "#fff"
                bodyContentColor2: controlsThemes.table.bodyContentColor2 || "#fff"
                bodyTextColor: controlsThemes.table.bodyTextColor || "#4a4a4a"
                scrollIndicatorColor: controlsThemes.table.scrollIndicatorColor || "#a0a0a0"
                scrollBackColor: controlsThemes.table.scrollBackColor || "#e0e0e0"
                dataModel: books_use_init_
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