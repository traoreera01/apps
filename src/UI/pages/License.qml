import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import "../compoments"
import "../pages"



Item {
    id: root
    implicitHeight: 500
    implicitWidth:  1000
    anchors.fill: parent
    clip: true
    Rectangle{
        id: rectangle
        color: "transparent"
        anchors.fill: parent

        Rectangle{
            width: 563
            height: 422
            anchors.verticalCenter: parent.verticalCenter
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#00000000"
            radius: 10
            Text{
                id: licenseText
                textFormat: Text.RichText
                color: "transparent"
                text:`<html>
                            <head>
                                <style>
                                body{
                                    font-family: 'Roboto',serif;
                                    color:`+ params.textColor+`;
                                    background-color: 'transparent';
                                    padding: 20px;
                                }
                                h1 {
                                    color: #007bff;
                                    text-align: center;
                                }
                                .license-text: {
                                    background-color: #fff;
                                    padding: 20px;
                                    border-radius: 5px;
                                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                                    margin: 0 auto;
                                    max-width: 600px;
                                    max-height: 900px;
                                }

                                </style>
                            </head>
                            <body>
                                <div class='license-text'>
                                    <h1>Licence BiblioApp</h1>
                                    <p>BiblioApp - Application de Gestion de Bibliothèque</p>
                                    <p>Version 1.0, avril 2024</p>
                                    <p>Copyright (C) [année] [votre nom]</p>
                                    <p>BiblioApp est un logiciel libre qui vous pouvez le redistribuer et/ou le modifier conformément aux termes de la Licence Publique Générale GNU <br>telle que publiée par la Free Software Foundation, soit la version 3 de la licence, soit (à votre choix) toute version ultérieure.</p>
                                    <p>Si vous avez recours à ce logiciel, vous pouvez le demander à l’adresse suivante : <a href='https://github.com/Biblioapp/BiblioApp'>https://github.com/Biblioapp/BiblioApp</a></p>
                                    <p>BiblioApp est distribué dans lespoir quil sera utile, mais SANS AUCUNE GARANTIE ; sans même la garantie implicite de COMMERCIALISABILITÉ ou dADÉQUATION À UN BUT PARTICULIER. Consultez la Licence Publique Générale GNU pour plus de détails.</p>
                                </div>
                            </body>
                        </html>`
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WordWrap
                font.bold: true
                clip: true


            }
        }
    }

}
