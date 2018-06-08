import QtQuick 2.0
import "../Vocabulary"

Rectangle {
    id:sprint
    color:"white"

    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:sprint
                x:width
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:sprint
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
        anchors.left: parent.left
        anchors.right: parent.right
        height: 70
        color:"black"

        z:1

        /*Rectangle{
            id:learnedWord
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width:parent.height*2
            color:"lightgreen"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    var curInd = list.listView.currentIndex
                    database.changeRecord(sprintModel.getId(list.listView.currentIndex),
                                          sprintModel.getWord(list.listView.currentIndex),
                                          sprintModel.getTranslation(list.listView.currentIndex),
                                          sprintModel.getPack(list.listView.currentIndex)+1,
                                          new Date());
                    if(curInd>0)
                        list.listView.currentIndex=curInd-1

                    sprintModel.updateModel()
                    myModel.updateModel()
                }
            }
        }*/

        Rectangle{
            id:rotateButton
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width:parent.height
            color:"blue"


            MouseArea{
                id:rotateButtonArea
                anchors.fill:parent
                onClicked: {
                    if(list.defaultState=="default")
                    {
                        list.defaultState="rotated"
                        list.changedState="default"
                    }
                    else
                    {
                        list.defaultState="default"
                        list.changedState="rotated"
                    }
                    list.rotateCard()
                }
            }

        }

        Rectangle{
            id:homeButton
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.height
            color:"white"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    sprint.state="closed"
                }
            }
        }

    }


    SwipeView{
        id:list
        anchors.top:banner.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z:0

        onSwapFrom: {
            console.log(fromDirection)
        }
    }

}
