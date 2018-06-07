import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:box
    signal swapFrom(string fromDirection)

    property string defaultState:"default"                  //we can change it in our properties(when we want rotated state to be default)
    property string changedState:"rotated"

    ListView{
        id: list
        anchors.fill: parent
        orientation: ListView.Horizontal

        model:myModel


        snapMode: ListView.SnapOneItem                      //only one item per swip

        highlightRangeMode: ListView.StrictlyEnforceRange   //in order to change currentIndex, when swiping

        onFlickStarted:  {                                  //when we leave our item it changes its state to default
            list.currentItem.getCard.state=defaultState
            console.log(list.currentIndex)
        }
        onFlickEnded: {
            list.currentItem.getCard.state=defaultState
            console.log(list.currentIndex)
        }

        delegate: SwipeView{
            id:mainDelegate
            width: box.width
            height: box.height
            property alias getCard:card

            Item{
                id:abb
                width:box.width
                height: box.height

                Card{
                    id:card
                    anchors.centerIn: parent
                    width: parent.width/2
                    height: parent.height/2
                    state: defaultState
                }

                Timer{                                         //timer to disable swiping during card rotation
                    id:timer
                    interval:400
                    running:false
                    repeat: false
                    onTriggered: {
                        list.interactive=true
                        console.log("TIMER")
                    }
                }


                MouseArea{                                      //handles vertical swiping
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

                            card.state=changedState

                        }
                        if(beginY-endY<-20)
                        {
                            list.interactive=false
                            timer.start()

                            swapFrom("fromTop")

                            card.state=defaultState
                        }
                    }
                }
            }

        }
    }

}
