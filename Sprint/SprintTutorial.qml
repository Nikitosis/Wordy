import QtQuick 2.0

Item {
    id:mainBox

    property int buttonsHeight:height/8
    property int buttonsWidth:width/2
    property int pageNum:0
    Rectangle{
        id:background
        anchors.fill: parent
        z:-1
        color:"white"
        opacity: 1
    }
    MouseArea{
        anchors.fill: parent
    }

    Item{
        id:firstPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==0
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10


            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:qsTr("This is Sprint. Here you learn new words. \n\n Everyday sprint gives you new words and upgrades previous ones to next pack. \n\n So you don't have to worry, which words to repeat today. Let our algorithms do all of the routine.")
            }
        }
    }

    Item{
        id:secondPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==1
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10


            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:qsTr("Here every word represents a card. Each card has word and definition on oposite sides. \n\n Slide up or down to rotate card. \n\n Slide left or right to change the word.")
            }
        }
    }

    Item{
        id:thirdPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==2
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10


            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:qsTr("If you want every card to be rotated by default, click this button:")
            }

            Image{
                width: mainBox.width
                height: mainBox.height/7
                horizontalAlignment: Image.AlignHCenter

                source: "qrc:/img/RotationButton.png"

                fillMode: Image.PreserveAspectFit
            }
        }
    }

    Row{
        id:navigation
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: buttonsHeight
        z:1


        Rectangle{
            id:skipButton
            width: buttonsWidth
            height: buttonsHeight

            Text{
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text:"Skip"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainBox.opacity=0
                    mainBox.enabled=false
                    tutorials.passSprintTutorial()
                }
            }
        }

        Rectangle{
            id:nextButton
            width: buttonsWidth
            height: buttonsHeight

            Text{
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text:"Next"
                font.bold: true
                color: "blue"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    pageNum=(pageNum+1)%3
                }
            }
        }
    }

    Behavior on opacity{
        NumberAnimation{duration: 150}
    }
}
