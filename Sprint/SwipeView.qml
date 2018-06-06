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

                /*MouseArea{
                    anchors.fill: parent
                    property int beginY:0
                    property int endY:0

                    onPressed: {
                        beginY=mouseY
                    }

                    onReleased: {
                        endY=mouseY
                        console.log(beginY,"   ",endY)
                        if(beginY-endY>15)
                        {
                            swapFrom("fromBottom")
                        }
                    }
                }*/
                SwipeView{
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
                }

            }

        }
    }

}
