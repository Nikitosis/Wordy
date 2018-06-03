import QtQuick 2.0

Item {
    id:box

    ListModel{
        id:simpleModel

        ListElement{
            word:"good"
            translation:"хороший"
        }
        ListElement{
            word:"bad"
            translation:"плохой"
        }
        ListElement{
            word:"easy"
            translation:"легко"
        }
        ListElement{
            word:"hard"
            translation:"тяжело"
        }
    }

    ListView{
        id:list
        anchors.fill: parent
        model:myModel


        delegate: Component{
            id:mainDelegate
            Item{
                anchors.left: parent.left
                anchors.right: parent.right
                height: 30
                Rectangle{    //border
                    z:0
                    anchors.fill: parent
                    color:"grey"
                }

                Rectangle{   //words
                    z:1
                    anchors.fill: parent
                    anchors.bottomMargin: 2

                    Text{
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text:word
                        font.pixelSize: 15
                    }

                    Text{
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        text:translation
                        font.pixelSize: 15
                    }
                }
            }
        }
    }



}
