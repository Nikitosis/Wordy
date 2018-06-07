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
        height: 50
        color:"black"

        z:1

        Rectangle{
            id:rotateButton
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width:parent.height
            color:"blue"

            MouseArea{
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
