import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import QtQuick.Pdf 

ApplicationWindow {
    visible: true
    width: 1200
    height: 800
    title: "Lecteur PDF avec Notes"

    PdfMultiPageView {
        id: pdfViewer
        anchors.fill: parent
        document: PdfDocument{
            source: "books.pdf"
        }  // Remplacez par le chemin de votre fichier PDF
        //onPageChanged: pdfManager.set_page(pageNumber)
        onCurrentPageChanged:{
            notesText.text = pdfManager.get_note_for_page(pageNumber);
            htmlPreview.text = notesText.text // Mettre à jour la prévisualisation
        }
    }

    Column {
        width: parent.width
        spacing: 10

        // Zone de saisie des notes en Markdown
        TextArea {
            id: notesText
            width: parent.width * 0.8
            height: 150
            placeholderText: "Ajoutez une note en Markdown pour cette page"
        }

        // Zone de prévisualisation HTML
        Text {
            id: htmlPreview
            width: parent.width * 0.8
            height: 300
            color: "black"
            textFormat: Text.RichText
            wrapMode: Text.Wrap
        }

        Row {
            spacing: 10

            Button {
                text: "Sauvegarder la note"
                onClicked: {
                    var page = pdfViewer.currentPage
                    var note = notesText.text
                    pdfManager.add_note_for_page(note, page)
                }
            }

            Button {
                text: "Ouvrir PDF"
                onClicked: {
                    var file = fileDialog.openFileDialog()
                    if (file) {
                        pdfManager.load_pdf(file)
                        pdfViewer.source = "file://" + file
                    }
                }
            }
        }

        FileDialog {
            id: fileDialog
            title: "Ouvrir un fichier PDF"
            nameFilters: ["Fichiers PDF (*.pdf)"]
            onAccepted: {
                var file = fileDialog.fileUrl
                if (file) {
                    pdfManager.load_pdf(file.toString())
                }
            }
        }
    }

    // Affichage des notes et navigation du PDF
    Connections {
        target: pdfManager
        onCurrent_page_changed: {
            console.log("Page actuelle: " + pageNumber)
            notesText.text = pdfManager.get_note_for_page(pageNumber)
            htmlPreview.text = notesText.text  // Mise à jour de la prévisualisation à chaque changement de page
        }
    }
}
