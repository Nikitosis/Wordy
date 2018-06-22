import QtQuick 2.0

Item {
    id:box
    property alias listView: list


    ListView{
        id:list
        anchors.fill: parent
        model:myModel

        property int lastItemIndex:-1

        delegate: Component{
            id:mainDelegate  

            Item{

                id:currentItem
                anchors.left: parent.left
                anchors.right: parent.right
                height: list.height/9

                state:"deselected"


                states:[State{
                        name:"selected"
                        PropertyChanges{
                            target:currentItem
                            height:list.height/5
                            }
                        PropertyChanges {
                            target: ratingBox
                            opacity:1
                        }
                    },
                    State{
                        name:"deselected"
                        PropertyChanges{
                            target:currentItem
                            height:list.height/9
                            }
                        PropertyChanges {
                            target: ratingBox
                            opacity:0

                        }
                    }
                ]
                transitions:Transition{
                    from:"selected"
                    to:"deselected"
                    reversible: true
                    NumberAnimation{
                        properties: "height,opacity"
                        duration: 300
                    }

                }

                onFocusChanged: {
                    if(list.currentIndex == index){
                            currentItem.state = 'selected';
                       }
                       else{
                             currentItem.state = 'deselected';
                       }
                }

                onStateChanged: {
                    ratingBox.updateRating(5-pack+1)
                }

                PackRating{
                    id:ratingBox
                    width: parent.width/2
                    height: parent.height/2.3
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle{   //words
                    color:"transparent"
                    anchors.fill: parent

                    Text{
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 5
                        text:word+pack+date
                        font.pixelSize: Math.min(parent.height/1.5,parent.width/25/1.3)
                    }

                    Text{

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 5
                        text:translation
                        font.pixelSize: Math.min(parent.height/1.5,parent.width/25/1.3)

                    }

                    Rectangle{    //bottom border
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 2
                        color:"grey"
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        list.currentIndex=index
                    }
                }
            }
        }
        //highlightMoveVelocity: 1000
        highlightMoveDuration:400
        highlight: Rectangle{
            color:"lightgrey"
        }
    }



}
