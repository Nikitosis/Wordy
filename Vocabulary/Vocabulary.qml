import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Rectangle {
    id:vocabulary
    color: "white"

    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:vocabulary
                x:-width
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:vocabulary
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
        id:banner
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 70

        z:1
        color:"black"


        Rectangle{
            id:homeButton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            color:"white"

            height: parent.height
            width: parent.height

            z:2

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    vocabulary.state="closed"
                }
            }
        }

        Text{
            id:bannerText
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: homeButton.right
            text:"Vocabulary"
            font.pixelSize: 20
            color:"white"
            fontSizeMode: Text.Fit
        }

        Rectangle{
            id:updateWordButton
            anchors.right: deleteWordButton.left
            anchors.verticalCenter: parent.verticalCenter
            color:"blue"

            height: parent.height
            width: parent.height

            z:2

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dialogUpdateWord.newWordName.text=myModel.getWord(list.listView.currentIndex)        //assign newWordName current word's name
                    dialogUpdateWord.newWordTranslation.text=myModel.getTranslation(list.listView.currentIndex) //assign current word's translation

                    dialogUpdateWord.open()
                }
            }
        }

        Rectangle{
            id:deleteWordButton
            anchors.right: addWordButton.left
            anchors.verticalCenter: parent.verticalCenter
            color:"orange"

            height: parent.height
            width: parent.height

            z:2

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dialogDeleteWord.open()                           //when we click on addWord,it opens new word dialog
                }
            }
        }

        Rectangle{
            id: addWordButton
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            color:"lightgreen"
            height: parent.height
            width: parent.height
            z:2

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dialogNewWord.open()                           //when we click on addWord,it opens new word dialog
                }
            }
        }

    }    //end banner

    VocabularyList{
        id:list
        anchors.top: banner.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        z:0

        onChangePack: {
            database.changeRecordVocabulary(id,word,translation,pack,date)
            console.log("Pack changed id=",id," pack=",pack)
            //myModel.updateModel()
        }

    }


   WordDialog{
       id:dialogNewWord
       width: parent.width

       onAccepted: {
           console.log("apply")
           var date=new Date()
           date.setDate(date.getDate())


           database.insertIntoTableVocabulary(newWordName.text,
                                    newWordTranslation.text,
                                    1,
                                    date);
           myModel.updateModel()
           newWordName.text=""
           newWordTranslation.text=""
       }
   }

   WordDialog{
       id:dialogUpdateWord
       width: parent.width

       onAccepted: {
           console.log("updated", newWordName.text,newWordTranslation.text)

           database.changeRecordVocabulary(myModel.getId(list.listView.currentIndex),
                                 newWordName.text,
                                 newWordTranslation.text,
                                 1,
                                 myModel.getDate(list.listView.currentIndex));

           myModel.updateModel()
           newWordName.text=""
           newWordTranslation.text=""
       }
   }



   MessageDialog{
       id:dialogDeleteWord
       title:"Удаление слова"
       text:"Подтвердите удаление слова\n"+myModel.getWord(list.listView.currentIndex)

       standardButtons: StandardButton.Cancel | StandardButton.Apply

       onApply: {
           database.removeRecordVocabulary(myModel.getId(list.listView.currentIndex))
           myModel.updateModel()
       }
   }
}
