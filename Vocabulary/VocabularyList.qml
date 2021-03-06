import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:box
    property alias listView: list
    property int footerHeight
    signal changePack(int id,string word,string translation,int pack,date date)


    ListView{
        id:list
        anchors.fill: parent
        model:vocabularyModel


        property int lastItemIndex:-1

        footer:Rectangle{
            height: footerHeight
            width: list.width
            color:"transparent"
        }

        delegate: Component{
            id:mainDelegate  


            Item{

                id:currentItem
                anchors.left: parent.left
                anchors.right: parent.right
                height: list.height/9
                clip:false
                //z:0

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
                            enabled:true
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
                            enabled:false
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
                    if(ratingBox.rating==-1)
                        ratingBox.updateRating(pack)                                    //set to actual pack if rating is undefined
                }

                Rectangle{   //words
                    color:"transparent"
                    anchors.fill: parent
                    z:1


                    PackRating{
                        id:ratingBox
                        width: parent.width/2
                        height: parent.height/2.3
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        onChangePack: box.changePack(vocabularyModel.getId(index),word,translation,newRating,new Date())
                        z:3

                    }

                    Text{
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: parent.width/23
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter

                        text:word//+pack+date
                        width:currentItem.width/2.5
                        wrapMode: Text.Wrap
                        font.pixelSize: Math.max(15,Math.min(parent.height/3,parent.width/25/1.3))
                    }

                    Text{

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: parent.width/23
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter

                        text:translation
                        width:currentItem.width/2.5
                        wrapMode: Text.Wrap
                        font.pixelSize: Math.max(15,Math.min(parent.height/3,parent.width/25/1.3))

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
