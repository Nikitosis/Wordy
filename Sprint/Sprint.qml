import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "../Vocabulary"

Rectangle {
    id:sprint
    color:"#fae3e3"

    clip:true

    function open()
    {
        sprint.state="opened"
        console.log("Sprint opened aaa")
        sprintModel.updateModel()

        if(!sprintModel.isAnyWords())
        {
            warningText.visible=true
        }
        else
        {
            warningText.visible=false
        }

        if(tutorials.isSprintTutorial())
        {
            tutorial.opacity=1
            tutorial.pageNum=0
            tutorial.enabled=true
        }
        else
        {
            tutorial.opacity=0
            tutorial.enabled=false
        }
    }

    function close()
    {
        sprint.state="closed"
        warningText.visible=false
    }

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


    SprintTutorial{
        id:tutorial
        height: parent.height
        width: parent.width

        z:10
    }

    Item{
        id:arrowHint
        anchors.fill: parent
        property int imgLength: Math.min(width/2,height/2)
        property int imgWidth:Math.min(height/15,width/15)
        property int imgMargin:Math.min(width/15,height/15)
        opacity: 0.15
        Image{
            id:verticalArrow

            anchors.verticalCenter: parent.verticalCenter
            //anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: parent.imgMargin
            height: parent.imgLength
            width: parent.imgWidth

            fillMode: Image.PreserveAspectFit
            source: "qrc:/img/SprintArrowVertical.png"
        }

        Image{
            id:horizontalArrow

            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.imgMargin
            height: parent.imgWidth
            width: parent.imgLength

            fillMode: Image.PreserveAspectFit
            source: "qrc:/img/SprintArrowHorizontal.png"
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

    Item{
        id:shuffleButton

        anchors.left: parent.left
        anchors.top: parent.top

        height: Math.min(parent.height/8,parent.width/4)
        width: Math.min(parent.height/8,parent.width/4)

        anchors.topMargin:  Math.min(sprint.height/25,sprint.width/25)
        anchors.leftMargin: Math.min(sprint.height/25,sprint.width/25)

        smooth:true

        Image{
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "qrc:/img/ShuffleButton.png"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                list.listView.currentIndex=0
                sprintModel.updateModelShuffle()
            }
        }
    }

    Text{
        id:warningText
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap

        font.pixelSize: Math.min(parent.width/30,parent.height/15)
        text:qsTr("There are no words for you to repeat today. Add more words in vocabulary.")
    }

}
