import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:box
    signal swapFrom(string fromDirection)

    ListView{
        id: list
        anchors.fill: parent
        orientation: ListView.Horizontal

        model:myModel


        snapMode: ListView.SnapOneItem

        delegate: SwipeView{
            id:mainDelegate
            width: box.width
            height: box.height
            Item{
                width:box.width
                height: box.height

                Card{
                    id:card
                    anchors.centerIn: parent
                    width: parent.width/2
                    height: parent.height/2
                    state:"default"
                }

                Timer{
                    id:timer
                    interval:400
                    running:false
                    repeat: false
                    onTriggered: {
                        list.interactive=true
                        console.log("TIMER")
                    }
                }


                MouseArea{
                    id:swipeHandler
                    anchors.fill: parent
                    property int beginY:0
                    property int endY:0

                    onPressed: {
                        beginY=mouseY
                        endY=mouseY
                    }
                    onPositionChanged: {
                        endY=mouseY
                        if(beginY-endY>20)
                        {
                            list.interactive=false
                            timer.start()

                            swapFrom("fromBottom")
                            card.state="rotated"

                        }
                        if(beginY-endY<-20)
                        {
                            list.interactive=false
                            timer.start()

                            swapFrom("fromTop")
                            card.state="default"
                        }
                    }
                }
                /*SwipeView{
                    id:view

                    anchors.fill: parent
                    orientation: "Vertical"

                    Rectangle{
                        Text{
                            anchors.centerIn: parent
                            text:word
                        }
                    }
                    Item{
                        Text{
                            anchors.centerIn: parent
                            text:translation
                        }
                    }
                }*/

            }

        }
    }

}
