import QtQuick 2.0

Item {
    id:box
    property alias listView: list

    ListView{
        id:list
        anchors.fill: parent
        model:myModel

        delegate: Component{
            id:mainDelegate
            Item{
                anchors.left: parent.left
                anchors.right: parent.right
                height: list.height/9

                Rectangle{   //words
                    color:"transparent"
                    anchors.fill: parent

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

        highlight: Rectangle{
            color:"lightgrey"
        }
    }



}
