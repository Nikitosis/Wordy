import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Rectangle {
    id:vocabulary
    color: "#e8f6e7"
    property alias list:list
    property alias dialogNewWord:dialogNewWord
    property alias dialogUpdateWord:dialogUpdateWord

    Row{
        id:optionRow
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.bottomMargin: Math.min(parent.height/30,parent.width/30)
        anchors.rightMargin: Math.min(parent.height/30,parent.width/30)

        property int   circleSize:Math.min(parent.height/8,parent.width/4)

        spacing: parent.width/12
        z:1

        Rectangle{
            id:deleteWordButton
            height: parent.circleSize
            width: parent.circleSize
            radius: parent.circleSize
            color:"#399c4c"

            opacity: list.listView.currentIndex==-1 ? 0 : 1     //not visible,if haven't selected any word

            Image {
                anchors.centerIn: parent
                width: parent.width-parent.width/2.5
                height: parent.height-parent.height/2.5
                source: "qrc:/img/DeleteIcon.png"

                fillMode: Image.PreserveAspectFit
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dialogDeleteWord.open()
                }
            }

            Behavior on opacity{
                NumberAnimation{duration: 100}
            }
        }

        Rectangle{
            id:updateWordButton
            height: parent.circleSize
            width: parent.circleSize
            radius: parent.circleSize
            color:"#399c4c"

            opacity: list.listView.currentIndex==-1 ? 0 : 1     //not visible,if haven't selected any word

            Image {
                anchors.centerIn: parent
                width: parent.width-parent.width/2.5
                height: parent.height-parent.height/2.5
                source: "qrc:/img/EditIcon.png"

                fillMode: Image.PreserveAspectFit
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dialogUpdateWord.newWordName.text=myModel.getWord(list.listView.currentIndex)        //assign newWordName current word's name
                    dialogUpdateWord.newWordTranslation.text=myModel.getTranslation(list.listView.currentIndex) //assign current word's translation

                    dialogUpdateWord.state="opened"
                }
            }

            Behavior on opacity{
                NumberAnimation{duration: 100}
            }
        }

        Rectangle{
            id:addWordButton
            height: parent.circleSize
            width: parent.circleSize
            radius: parent.circleSize
            color:"#399c4c"

            Image {
                anchors.centerIn: parent
                width: parent.width-parent.width/2.5
                height: parent.height-parent.height/2.5
                source: "qrc:/img/AddIcon.png"

                fillMode: Image.PreserveAspectFit
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dialogNewWord.state="opened"
                }
            }
        }

    }

    VocabularyList{
        id:list
        anchors.fill: parent


        clip:true

        //z:0

        onChangePack: {
            database.changeRecordVocabulary(id,word,translation,pack,date)
            console.log("Pack changed id=",id," pack=",pack)
            //myModel.updateModel()
        }

    }


   WordDialog{
       id:dialogNewWord
       width: parent.width
       height: parent.height
       z:5

       state:"closed"
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
       height: parent.height
       z:5

       state:"closed"
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

   states:[
       State{
           name:"closed"
           PropertyChanges{
               target:vocabulary
               opacity:0
               enabled:false
           }
       },
       State{
           name:"opened"
           PropertyChanges{
               target:vocabulary
               opacity:1
               enabled:true
           }
       }
   ]

   transitions: Transition {
       from: "closed"
       to: "opened"
       reversible: true
       /*onRunningChanged: {
           if(state=="closed")
               z=0
           else
               z=10
       }*/

       NumberAnimation{
           properties: "opacity"
           duration: 600
       }
   }
}
