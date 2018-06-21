import QtQuick 2.0

Item {
    id:box
    property alias listView: list

    ListView{
        id:list
        anchors.fill: parent
        model:myModel

        property int lastItemIndex:-1


        onCurrentItemChanged:{
            list.currentItem.state="opened"                                //change state of current item(expand)
            if(lastItemIndex!=-1)
                list.contentItem.children[lastItemIndex].state=""          //change previous item's state to previous
            lastItemIndex=list.currentIndex
        }

        delegate: Component{
            id:mainDelegate  
            Item{
                id:currentItem
                anchors.left: parent.left
                anchors.right: parent.right
                height: list.height/9

                states:State{
                    name:"opened"
                    PropertyChanges{
                        target:currentItem
                        height:list.height/5
                    }

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
