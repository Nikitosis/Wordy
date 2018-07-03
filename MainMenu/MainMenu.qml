import QtQuick 2.0
import QtQuick.Controls 2.0

    Item{
        id:main
        signal vocabularyClicked()
        signal sprintClicked()
        signal testClicked()
        signal helpClicked()
        z:0



        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            text:"Wordy"
            color:"black"
            font.pixelSize: 29
        }

        Item{

            id:box

            anchors.fill: parent

            anchors.topMargin: parent.height/8
            anchors.bottomMargin: parent.height/8
            anchors.leftMargin: parent.width/8
            anchors.rightMargin: parent.width/8

            //rowSpacing: parent.height/7


            MainMenuButton{
                id:vocabulary
                height: parent.height/3.5
                width: parent.width/3
                anchors.left: parent.left
                anchors.top: parent.top
                buttonText.text: "словарь"

                onClicked: {
                    vocabularyClicked()
                }
            }

            MainMenuButton{
                id:sprint
                height: parent.height/3.5
                width: parent.width/3
                anchors.top: parent.top
                anchors.right: parent.right
                buttonText.text: "спринт"

                onClicked: {
                    sprintClicked()
                }
            }

            MainMenuButton{
                id:test
                height: parent.height/3.5
                width: parent.width/3
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                buttonText.text: "тест"

                onClicked: {
                    testClicked()
                }
            }

            MainMenuButton{
                id:help
                height: parent.height/3.5
                width: parent.width/3
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                buttonText.text: "помощь"

                onClicked: {
                    helpClicked()
                }
            }
        }






    }
