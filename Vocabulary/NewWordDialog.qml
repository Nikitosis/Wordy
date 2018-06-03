import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Dialog{
    id:dialogNewWord
    title:"Добавление слова"

   // height: 400
    //width: 400

    standardButtons: StandardButton.Save | StandardButton.Cancel

    property string maxWordLength: "10"

    onAccepted: {
        console.log("apply")
        database.insertIntoTable(newWordName.text,newWordTranslation.text)
        myModel.updateModel()
        newWordName.text=""
        newWordTranslation.text=""
    }

    contentItem: Rectangle{
        //anchors.fill: parent
        height: vocabulary.height/2
        width: vocabulary.width
        color:"black"

        Text{
            anchors.bottom: newWordNameRec.top
            anchors.left: parent.left
            anchors.margins: 5
            text:"Слово в оригинале"
            color:"white"
        }

        Text{
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
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 5
            color:"white"
            TextInput{
                id:newWordName
                anchors.fill: parent
                font.pixelSize: Math.min(parent.height/1.5,width/length*2)
                validator: RegExpValidator { regExp: /[a-zA-Z]{28}/  }               //maximum 20 letters
            }
        }


        Rectangle{
            id:newWordTranslationRec
            height: parent.height/6
            width: parent.width/2.3
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 5
            color:"white"
            TextInput{
                id:newWordTranslation
                anchors.fill: parent
                font.pixelSize: Math.min(parent.height/1.5,width/length*2)
                validator: RegExpValidator { regExp: /[a-zA-Z]{28}/  }               //maximum 20 letters
            }
        }

        Button{
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            height: parent.height/4
            width: parent.width/3
            anchors.margins: 5
            Text{
                anchors.centerIn: parent
                text:"Apply"
                color:"black"
            }
            onClicked: {
                dialogNewWord.click(StandardButton.Save)
            }
        }

        Button{
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            height: parent.height/4
            width: parent.width/3
            anchors.margins: 5
            Text{
                anchors.centerIn: parent
                text:"Cancel"
                color:"black"
            }

            onClicked: {
                dialogNewWord.click(StandardButton.Cancel)
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
