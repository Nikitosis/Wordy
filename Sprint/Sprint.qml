import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "../Vocabulary"

Rectangle {
    id:sprint
    color:"#fae3e3"

    clip:true

    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:sprint
                opacity:0
                enabled:false
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:sprint
                opacity:1
                enabled:true
            }
        }
    ]

    transitions: Transition{
        from:"closed"
        to:"opened"
        reversible: true

        NumberAnimation{
            properties: "opacity"
            duration: 600
        }
    }




    SwipeView{
        id:list
        anchors.top:parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        //z:0

        onSwapFrom: {
            console.log(fromDirection)
        }
    }

    Item{
        id:rotateButton

        property int rotatonAngle:0

        anchors.right: parent.right
        anchors.top: parent.top

        height: Math.min(parent.height/8,parent.width/4)
        width: Math.min(parent.height/8,parent.width/4)

        anchors.topMargin:  Math.min(sprint.height/25,sprint.width/25)
        anchors.rightMargin: Math.min(sprint.height/25,sprint.width/25)

        Image{
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "qrc:/img/RotationButton.png"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                parent.rotatonAngle+=360                        //due to clockwise rotation
                parent.rotation=parent.rotatonAngle

                list.rotateCard()
            }
        }

        Behavior on rotation{
            NumberAnimation{duration:400}
        }
    }

    MessageDialog{
        id:warningDialog
        title: "No words"
        text:"There are no words for you to repeat today. Add more words in vocabulary."

    }
    onStateChanged: {
        if(state=="opened" && !sprintModel.isAnyWords())
            warningDialog.open()
    }

}
