import QtQuick 6.5
import "../effect"
import "../compoments"
import QtQuick.Effects 6.5
import QtQuick.Layouts 6.5
import QtQuick.Controls 6.5


Window {
    id: window
    width: 1200
    height: 630
    minimumHeight: 630
    minimumWidth: 1200
    visible: true
    title: qsTr("BIBLIOapp")
    property string text_: ""
    PropertyAnimation{
        id: menuAnimation
        target: menuRectContent
        easing.bezierCurve: appColor.animations.easing
        properties: "width"
        duration:appColor.animations.duration
    }
    QtObject{
        id: internal_app
        function themes(checked){
            themesConf.swith_theme(checked)
            //themesConf.reloadThemes()
            //updateUI.updatingUserInterface()
            if(checked === true){
                colorAnimNenu.to = appColor.allCntBg
                colorAnimNenu.from= appColor.animColor
                bgAnimColor.to = appColor.allCntBg
                bgAnimColor.from = appColor.animColor
                colorAnimNenu.running = true
                bgAnimColor.running = true
            }
            else{
                colorAnimNenu.from = appColor.allCntBg
                colorAnimNenu.to=appColor.animColor
                bgAnimColor.from = appColor.allCntBg
                bgAnimColor.to = appColor.animColor
                colorAnimNenu.running = true
                bgAnimColor.running = true
            }
            if (biblio.clikedIs){
                internal_app.biblio_Shortcuts(themesBtn.onCheckedChanged)
            }
            if (home.clikedIs){
                internal_app.home_Shortcuts(themesBtn.onCheckedChanged)
            }
            if (settings.clikedIs){
                internal_app.params_Shortcuts(themesBtn.onCheckedChanged)
            }
            if (books.clikedIs){
                internal_app.books_Shortcuts(themesBtn.onCheckedChanged)
            }
            if (commouty.clikedIs){
                internal_app.community_Shortcuts(themesBtn.onCheckedChanged)
            }
            if (forum.clikedIs){
                internal_app.forum_Shortcuts(themesBtn.onCheckedChanged)
            }

        }
        function model_text_return(index){
            switch(index){
                case 0: return window.text_ = userProfile.nom
                case 1: return window.text_ = userProfile.prenom
                case 2: return window.text_ = profileComplement.dates
                case 3: return window.text_ = userProfile.email
                case 4: return window.text_ = userProfile.level
                case 5: return window.text_ = profileComplement.dates
                case 6: return window.text_ = userProfile.email
                case 7: return window.text_ = userProfile.level
            }
        }

        function menuColabs(){
            if(menuRectContent.width ===230 ){
                menuAnimation.from = 230
                menuAnimation.to = 45
                recenent_open.visible = false
                                
            }else{
                menuAnimation.from = 45
                menuAnimation.to = 230
                recenent_open.visible = true
            }
            menuAnimation.running = true
        }

        function params_Shortcuts(checked){
            home.icoUrls = icons.animateIco.home // "../src/changeColor/home.svg"
            books.icoUrls = icons.animateIco.file //"../src/changeColor/file.svg"
            settings.icoUrls = icons.settings //"../src/ico/settings.svg"
            biblio.icoUrls =  icons.animateIco.book //"../src/changeColor/book.svg"
            home.bgColor = appColor.BtnAimate.defaultColor
            books.bgColor = appColor.BtnAimate.defaultColor
            settings.bgColor = appColor.BtnAimate.animateColor
            biblio.bgColor = appColor.BtnAimate.defaultColor
            home.textColor  = appColor.BtnAimate.defaultColorText
            books.textColor = appColor.BtnAimate.defaultColorText
            settings.textColor = appColor.BtnAimate.animateTextColor
            biblio.textColor = appColor.BtnAimate.defaultColorText
            commouty.textColor =appColor.BtnAimate.defaultColorText
            commouty.bgColor = appColor.BtnAimate.defaultColor
            commouty.clikedIs = false
            home.clikedIs = false
            biblio.clikedIs = false
            settings.clikedIs = true
            books.clikedIs = false
            forum.clikedIs = false
            forum.icoUrls = icons.animateIco.forum
            forum.bgColor = appColor.BtnAimate.defaultColor
            forum.textColor = appColor.BtnAimate.defaultColorText
            if (!checked){
                stackView.push("Settings.qml")
            }   
        }

        function forum_Shortcuts(checked){
            commouty.textColor = appColor.BtnAimate.defaultColorText
            commouty.bgColor = appColor.BtnAimate.defaultColor
            commouty.clikedIs = false

            home.icoUrls = icons.animateIco.home // "../src/changeColor/home.svg"
            books.icoUrls = icons.animateIco.file //"../src/changeColor/file.svg"
            settings.icoUrls = icons.animateIco.settings //"../src/ico/settings.svg"
            forum.icoUrls = icons.animateIco.forum
            forum.bgColor = appColor.BtnAimate.animateColor
            forum.textColor = appColor.BtnAimate.animateTextColor
            forum.clikedIs = true
            biblio.icoUrls =  icons.animateIco.book 
            home.bgColor = appColor.BtnAimate.defaultColor
            books.bgColor = appColor.BtnAimate.defaultColor
            settings.bgColor = appColor.BtnAimate.defaultColor
            biblio.bgColor = appColor.BtnAimate.defaultColor
            home.textColor  = appColor.BtnAimate.defaultColorText
            books.textColor = appColor.BtnAimate.defaultColorText
            settings.textColor = appColor.BtnAimate.defaultColorText
            biblio.textColor = appColor.BtnAimate.defaultColorText
            commouty.textColor =appColor.BtnAimate.defaultColorText
            commouty.bgColor = appColor.BtnAimate.defaultColor
            commouty.clikedIs = false
            home.clikedIs = false
            biblio.clikedIs = false
            settings.clikedIs = false
            books.clikedIs = false
            if (!checked){
                print("okk")
            }
        }

        function community_Shortcuts(checked){
            home.icoUrls = icons.animateIco.home
            books.icoUrls = icons.animateIco.file
            settings.icoUrls = icons.animateIco.settings
            biblio.icoUrls = icons.animateIco.book
            home.bgColor = appColor.BtnAimate.defaultColor
            books.bgColor = appColor.BtnAimate.defaultColor
            settings.bgColor = appColor.BtnAimate.defaultColor
            biblio.bgColor = appColor.BtnAimate.defaultColor
            commouty.bgColor = appColor.BtnAimate.animateColor
            home.textColor = appColor.BtnAimate.defaultColorText
            books.textColor = appColor.BtnAimate.defaultColorText
            settings.textColor = appColor.BtnAimate.defaultColorText
            biblio.textColor = appColor.BtnAimate.defaultColorText
            commouty.textColor = appColor.BtnAimate.animateTextColor
            home.clikedIs = false
            biblio.clikedIs = false
            settings.clikedIs = false
            books.clikedIs = false
            commouty.clikedIs = true
            forum.clikedIs = false
            forum.icoUrls = icons.animateIco.forum
            forum.bgColor = appColor.BtnAimate.defaultColor
            forum.textColor = appColor.BtnAimate.defaultColorText
            if(!checked){
                print("ook")
            }
            
        }

        function books_Shortcuts(checked){
            home.icoUrls = icons.animateIco.home
            books.icoUrls = icons.file
            settings.icoUrls = icons.animateIco.settings
            biblio.icoUrls = icons.animateIco.book
            home.bgColor = appColor.BtnAimate.defaultColor
            books.bgColor =  appColor.BtnAimate.animateColor
            settings.bgColor = appColor.BtnAimate.defaultColor
            biblio.bgColor = appColor.BtnAimate.defaultColor
            home.textColor = appColor.BtnAimate.defaultColorText
            books.textColor = appColor.BtnAimate.animateTextColor
            settings.textColor = appColor.BtnAimate.defaultColorText
            biblio.textColor = appColor.BtnAimate.defaultColorText
            commouty.textColor =appColor.BtnAimate.defaultColorText
            commouty.bgColor = appColor.BtnAimate.defaultColor
            commouty.clikedIs = false
            home.clikedIs = false
            biblio.clikedIs = false
            settings.clikedIs = false
            books.clikedIs = true
            forum.clikedIs = false
            forum.icoUrls = icons.animateIco.forum
            forum.bgColor = appColor.BtnAimate.defaultColor
            forum.textColor = appColor.BtnAimate.defaultColorText
            if(!checked){
            stackView.push('Files.qml')}
        }

        function biblio_Shortcuts(checked){
            home.icoUrls = icons.animateIco.home
            books.icoUrls = icons.animateIco.file
            settings.icoUrls = icons.animateIco.settings
            biblio.icoUrls = icons.book
            home.bgColor = appColor.BtnAimate.defaultColor
            settings.bgColor = appColor.BtnAimate.defaultColor
            books.bgColor =  appColor.BtnAimate.defaultColor
            biblio.bgColor = appColor.BtnAimate.animateColor
            home.textColor = appColor.BtnAimate.defaultColorText
            books.textColor = appColor.BtnAimate.defaultColorText
            settings.textColor = appColor.BtnAimate.defaultColorText
            biblio.textColor = appColor.BtnAimate.animateTextColor
            commouty.textColor =appColor.BtnAimate.defaultColorText
            commouty.bgColor = appColor.BtnAimate.defaultColor
            commouty.clikedIs = false
            home.clikedIs = false
            biblio.clikedIs = true
            settings.clikedIs = false
            books.clikedIs = false
            forum.clikedIs = false
            forum.icoUrls = icons.animateIco.forum
            forum.bgColor = appColor.BtnAimate.defaultColor
            forum.textColor = appColor.BtnAimate.defaultColorText
            if (!checked){stackView.push('Books.qml')}

        }

        function home_Shortcuts(checked){
            home.icoUrls = icons.home
            books.icoUrls = icons.animateIco.file
            settings.icoUrls = icons.animateIco.settings
            biblio.icoUrls = icons.animateIco.book
            home.textColor = appColor.BtnAimate.animateTextColor
            home.bgColor = appColor.BtnAimate.animateColor
            books.bgColor =  appColor.BtnAimate.defaultColor
            biblio.bgColor = appColor.BtnAimate.defaultColor
            settings.bgColor = appColor.BtnAimate.defaultColor
            books.textColor = appColor.BtnAimate.defaultColorText
            settings.textColor = appColor.BtnAimate.defaultColorText
            biblio.textColor = appColor.BtnAimate.defaultColorText
            commouty.textColor =appColor.BtnAimate.defaultColorText
            commouty.bgColor = appColor.BtnAimate.defaultColor
            commouty.clikedIs = false
            home.clikedIs = 1
            biblio.clikedIs = 0
            settings.clikedIs = 0
            books.clikedIs = 0
            forum.clikedIs = false
            forum.icoUrls = icons.animateIco.forum
            forum.bgColor = appColor.BtnAimate.defaultColor
            forum.textColor = appColor.BtnAimate.defaultColorText
            if (!checked){stackView.push("Homes_new.qml")}
        }

    }
    ColorAnimation {
        id: bgAnimColor
        property: "color"
        duration: appColor.amimationColor.duration
        target: bg
        easing.bezierCurve: appColor.amimationColor.easing

    }
    ColorAnimation {
        id: colorAnimNenu
        target: menuRectContent
        property: "color"
        duration: appColor.amimationColor.duration
        easing.bezierCurve: appColor.amimationColor.easing
    }
    Rectangle {
        id: bg
        color:  appColor.bgColor
        border.width: 0
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        clip: true
        anchors.leftMargin: 0
        anchors.topMargin: 0
        Rectangle {
            id: rectangle
            color: "transparent"
            border.width: 0
            anchors.left: menuRectContent.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: -1
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            clip: true
            StackView {
                id: stackView
                width: parent.width
                height: parent.height
                anchors.left: menuRectContent.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                initialItem: Homes_new{
                    clip: true
                }
            }
        }
        Rectangle {
            id: menuRectContent
            width: 230
            color:appColor.menu.color
            border.color: appColor.menu.borderColor
            radius: appColor.menu.radius
            border.width: 0
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.topMargin: -10
            anchors.bottomMargin: -10
            clip: true
            Rectangle{
                id: topBarBtn
                width: parent.width
                height: 80
                anchors.top: parent.top
                anchors.topMargin: 0
                color: appColor.TopBarBtn.color
                Rectangle {
                    id: menuColabs
                    x: 0
                    y: 308
                    width: parent.width
                    height: 40
                    color: "#00000000"
                    border.width: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.verticalCenterOffset: 6
                    clip: true
                    MouseArea{
                        anchors.fill: parent
                        onClicked: internal_app.menuColabs()
                    }
                    Rectangle {
                        id: rectangle3
                        y: 10
                        width: 10
                        height: 10
                        color: appColor.logoColor
                        radius: 5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: rectangle2.right
                        anchors.leftMargin: 0
                    }

                    Rectangle {
                        id: rectangle2
                        y: 5
                        width: 20
                        height: 20
                        color: appColor.logoColor
                        radius: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 9
                    }

                    Text {
                        id: appTitle
                        width: 132
                        height: 21
                        color: appColor.menu.textColor
                        text: qsTr("Student Life")
                        anchors.verticalCenter: rectangle2.verticalCenter
                        anchors.left: rectangle3.right
                        anchors.leftMargin: 10
                        font.pixelSize: 17
                        font.wordSpacing: -0.4
                        font.styleName: "ExtraBold"
                        font.family: "Montserrat"
                    }
                }
            }
            Column {
                id: column
                width: menuRectContent.width
                height: 223
                anchors.top: parent.top
                anchors.topMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 5
                spacing: 1
                BtnAnimate {
                    id: home
                    width: column.width
                    height: 35
                    text: "Aceuille"
                    icoUrls: icons.home
                    
                    raduisIn:appColor.BtnAimate.raduis
                    bgColor: appColor.BtnAimate.animateColor
                    textColor: appColor.BtnAimate.animateTextColor
                    
                    onClicked: internal_app.home_Shortcuts(false)
                }

                BtnAnimate {
                    id: biblio
                    width: column.width
                    height: 35
                    raduisIn: appColor.BtnAimate.raduis
                    text: "Biliotheque"
                    icoUrls: icons.animateIco.book
                    bgColor:"transparent"
                    textColor: appColor.BtnAimate.defaultColorText
                    onClicked: internal_app.biblio_Shortcuts(false)
                }

                BtnAnimate {
                    id: books
                    width: column.width
                    height: 35
                    text: "Livres"
                    icoUrls: icons.animateIco.file
                    textColor: appColor.BtnAimate.defaultColorText
                    raduisIn: appColor.BtnAimate.raduis
                    bgColor: appColor.BtnAimate.defaultColor
                    onClicked: internal_app.books_Shortcuts(false)
                }
                BtnAnimate {
                    id: commouty
                    width: column.width
                    height: 35
                    text: "Communaute"
                    icoUrls: icons.community
                    textColor: appColor.BtnAimate.defaultColorText
                    raduisIn: appColor.BtnAimate.raduis
                    bgColor: appColor.BtnAimate.defaultColor
                    onClicked: internal_app.community_Shortcuts(false)

                }
                BtnAnimate {
                    id: forum
                    width: column.width
                    height: 35
                    text: "Forum"
                    icoUrls: icons.forum
                    textColor: appColor.BtnAimate.defaultColorText
                    raduisIn: appColor.BtnAimate.raduis
                    bgColor: appColor.BtnAimate.defaultColor

                    onClicked: internal_app.forum_Shortcuts(false)
                }

                BtnAnimate {
                    id: settings
                    width: column.width
                    height: 35
                    text: "Parametre"
                    icoUrls:icons.animateIco.settings
                    icon.color: "#ffffff"
                    bgColor: appColor.BtnAimate.defaultColor
                    raduisIn:  appColor.BtnAimate.raduis
                    textColor: appColor.BtnAimate.defaultColorText
                    onClicked: internal_app.params_Shortcuts(false)
                }
            }
            Rectangle {
                id: separator_
                width: parent.width - 50
                height: 1
                color: appColor.recent_open.separtorColor
                anchors.top: column.bottom
                anchors.topMargin: 20
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: image
                height: 16
                anchors.left: parent.left
                anchors.top: separator_.bottom
                anchors.leftMargin: 17
                anchors.topMargin: 10
                source: icons.recent_open
                fillMode: Image.PreserveAspectFit
                clip:true
            }

            Text {
                id: _text
                text: qsTr("Recemments Ouverts")
                anchors.top: separator_.bottom
                anchors.topMargin: 10
                anchors.left:image.right
                anchors.leftMargin: 20
                font.pixelSize: 12
                font.family: "Montserrat"
                clip: true 
                color: appColor.recent_open.text_color
            }

            Column{
                id: recenent_open
                anchors.top: _text.bottom
                anchors.bottom: themesBtn.top
                anchors.topMargin: 18
                anchors.bottomMargin: 5
                width: parent.width - 40

                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                spacing: 10
                Repeater{
                    model: 7
                    Text {
                        id: _name
                        text: internal_app.model_text_return(model.index)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        //font.family: "Montserrat"
                        font.pointSize: 8
                        color:  appColor.recent_open.text_color
                        font.styleName: "Regular"
                        font.family: "Segoe UI"
                    }
                }
            }
            CustomSwith {
                id: themesBtn
                y: 586
                width: 66
                height: 35
                anchors.left: parent.left
                anchors.leftMargin: 67
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                checkColor: appColor.swithbtn.checkColor
                unchekColor: appColor.swithbtn.unchekColor
                roundColor: appColor.swithbtn.roundColor
                darkImgUrl: icons.moon
                lightImgUrl: icons.sun
                checked: swithvalue
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                onCheckedChanged:internal_app.themes(themesBtn.checked)
            }

        }

        Rectangle {
            id: popContent
            width: 800
            height: 600
            color: 'transparent' 
            anchors.verticalCenter: parent.verticalCenter 
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            PopContent{
                id:popContentherrr
                width: popContent.width
                height: popContent.height
                bgColor:appColor.popContent.color
                anchors.centerIn: parent
                Loader{
                    id:loderDescription
                    anchors.fill:parent
                }
            }
        }
        
    }
    Timer{
        interval: 6000
        repeat: true
        running: true

        onTriggered:{
            
        }
    }
    Shortcut{
        sequence: "Ctrl+Tab"
        onActivated:{
            themesBtn.checked = !themesBtn.checked
            console.log("themesBtn.checked",themesBtn.checked);
        }
    }
    Shortcut{
        sequence: "Ctrl+K"
        onActivated: {
            popContentherrr.open()
            loderDescription.source = "SearchSettings.qml"
        }
    }
    Shortcut{
        sequence: StandardKey.Quit
        context: Qt.ApplicationShortcut
        onActivated: Qt.quit()
    }
    Shortcut{
        sequence: "Ctrl+M"
        context: Qt.ApplicationShortcut
        onActivated: internal_app.menuColabs()
    }
    Shortcut{
        sequence: "Ctrl+P"
        context: Qt.ApplicationShortcut
        onActivated: internal_app.params_Shortcuts(true)
    }
}