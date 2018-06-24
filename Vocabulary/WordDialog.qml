import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Dialog{
    id:dialogWord
    title:"Добавление слова"

   // height: 400
    //width: 400

    standardButtons: StandardButton.Save | StandardButton.Cancel

    property int maxWordLength: 30
    property alias newWordName: newWordName
    property alias newWordTranslation: newWordTranslation

    contentItem: Rectangle{
        //anchors.fill: parent
        height: vocabulary.height/2
        width: vocabulary.width
        color:"black"

        Text{
            id:newWordText
            anchors.bottom: newWordNameRec.top
            anchors.left: parent.left
            anchors.margins: 5
            text:"Слово в оригинале"
            color:"white"
        }

        Text{
            id:newWordTranslationText
            anchors.bottom: newWordTranslationRec.top
            anchors.right: parent.right
            anchors.margins: 5
            text:"Перевод слова"
            color:"white"
        }

        Rectangle{
            id:newWordNameRec
            height: parent.height/6
            width: parent.width/2.3
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 5
            anchors.topMargin: newWordText.height+10
            color:"white"
            TextInput{
                id:newWordName
                anchors.fill: parent
                font.pixelSize: Math.min(parent.height/1.6,width/length*1.9)
                maximumLength: maxWordLength

                verticalAlignment: Text.AlignVCenter
                //validator: RegExpValidator { regExp: /[a-zA-Zа-яА-Я- ()/,.]{25}/  }               //validate
            }
        }


        Rectangle{
            id:newWordTranslationRec
            height: parent.height/6
            width: parent.width/2.3
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 5
            anchors.topMargin: newWordText.height+10
            color:"white"
            TextInput{
                id:newWordTranslation
                anchors.fill: parent
                font.pixelSize: Math.min(parent.height/1.6,width/length*1.9)
                maximumLength: maxWordLength

                verticalAlignment: Text.AlignVCenter

                //validator: RegExpValidator { regExp: /[a-zA-Zа-яА-Я- ()/,.]{25}/  }               //validate
            }
        }

        Button{
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            height: parent.height/4
            width: parent.width/2.3
            anchors.margins: 5
            Text{
                anchors.centerIn: parent
                text:"Apply"
                color:"black"
            }
            onClicked: {
                dialogWord.click(StandardButton.Save)
            }
        }

        Button{
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            height: parent.height/4
            width: parent.width/2.3
            anchors.margins: 5
            Text{
                anchors.centerIn: parent
                text:"Cancel"
                color:"black"
            }

            onClicked: {
                dialogWord.click(StandardButton.Cancel)
            }
        }

        MouseArea{                                          //background mouseArea to hide keyboard when click outside TextEdit
            anchors.fill: parent
            z:-1
            onClicked: {
                console.log("hide keyboard")
                Qt.inputMethod.hide()                      //hides keyboard
                newWordName.focus=false                    //removes the focus from TextEdits(get rid of blue triangle)
                newWordTranslation.focus=false
            }
        }

    }

}
