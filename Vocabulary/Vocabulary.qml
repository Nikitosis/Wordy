import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Rectangle {
    id:vocabulary
    color: "white"

    Rectangle{
        id:banner
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: dictionary.height/5

        z:1
        color:"black"

        Text{
            anchors.centerIn: parent
            text:"Vocabulary"
            font.pixelSize: 20
            color:"white"
        }
    }

    VocabularyList{
        id:list
        anchors.top: banner.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        z:0
    }


    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:dictionary
                x:-width
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:dictionary
                x:0
            }
        }
    ]

    transitions: Transition{
        from:"closed"
        to:"opened"
        reversible: true

        NumberAnimation{
            properties: "x"
            duration: 500
        }
    }

    Rectangle{
        id: addWordButton
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Math.min(parent.width,parent.height)/30
        radius: 100
        color:"lightgreen"
        height: Math.min(parent.width,parent.height)/10
        width:  Math.min(parent.width,parent.height)/10
        z:3

        MouseArea{
            anchors.fill: parent
            onClicked: {
                dialogNewWord.open()                           //when we click on addWord,it opens new word dialog
                myModel.updateModel()
            }
        }
    }

    Dialog{
        id:dialogNewWord
        title:"Добавление слова"
       // height: 400
        //width: 400

        standardButtons: StandardButton.Save | StandardButton.Cancel

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
                width: parent.width/3
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 5
                color:"white"
                TextEdit{
                    id:newWordName
                    font.pixelSize: parent.height/1.5
                    anchors.fill: parent
                }
            }


            Rectangle{
                id:newWordTranslationRec
                height: parent.height/6
                width: parent.width/3
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 5
                color:"white"
                TextEdit{
                    id:newWordTranslation
                    font.pixelSize: parent.height/1.5
                    anchors.fill: parent
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



        }

    }
}
