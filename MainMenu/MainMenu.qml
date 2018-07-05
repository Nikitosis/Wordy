import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

    Item{
        id:main
        signal vocabularyOpenClicked()
        signal sprintOpenClicked()
        signal testOpenClicked()
        signal helpOpenClicked()

        signal vocabularyCloseClicked()
        signal sprintCloseClicked()
        signal testCloseClicked()
        signal helpCloseClicked()

        function statesToSelected()
        {
            vocabulary.state="selected"
            sprint.state="selected"
            test.state="selected"
            help.state="selected"
        }

        function statesToDeselected()
        {
            vocabulary.state="deselected"
            sprint.state="deselected"
            test.state="deselected"
            help.state="deselected"
        }

        function resetZ()
        {
            vocabulary.z=3
            sprint.z=2
            test.z=1
            help.z=0
        }

        MainMenuButton{
            //visible: false
            id:vocabulary
            width: parent.width
            height: parent.height/4
            x:0
            y:0

            mainText:"Vocabulary"
            backgroundColor: "#a6f3a0"
            deselectedY: 0
            shadowSize: parent.height/100
            imgSource: "qrc:/img/VocabularyBackground.png"
            imgOpacity: 0.2
            state:"deselected"

            z:3
            deselectedZ: 3


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(parent.state=="deselected")
                    {
                        vocabularyOpenClicked()
                        statesToSelected()
                        parent.z=4
                    }
                    else
                    {
                        vocabularyCloseClicked()
                        statesToDeselected()
                        resetZ()
                    }
                }
            }


        }

        MainMenuButton{
            //visible: false
            id:sprint
            width: parent.width
            height: parent.height/4
            x:0
            y:parent.height/4

            mainText:"Sprint"
            backgroundColor:"#e78a8a"
            deselectedY: parent.height/4
            shadowSize: parent.height/100
            imgSource: "qrc:/img/SprintBackground.jpg"
            imgOpacity: 0.1
            state:"deselected"

            z:2
            deselectedZ: 2


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(parent.state=="deselected")
                    {
                        sprintOpenClicked()
                        statesToSelected()
                        parent.z=4
                    }
                    else
                    {
                        sprintCloseClicked()
                        statesToDeselected()
                        resetZ()
                    }
                }
            }



        }

        MainMenuButton{
            //visible: false
            id:test
            width: parent.width
            height: parent.height/4
            x:0
            y:parent.height/4 *2

            mainText:"Test"
            backgroundColor: "#61d5f2"
            deselectedY: parent.height/4 *2
            shadowSize: parent.height/100
            imgSource: "qrc:/img/TestBackground.jpg"
            imgOpacity: 0.15
            state:"deselected"

            z:1
            deselectedZ: 1

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(parent.state=="deselected")
                    {
                        testOpenClicked()
                        statesToSelected()
                        parent.z=4
                    }
                    else
                    {
                        testCloseClicked()
                        statesToDeselected()
                        resetZ()
                    }
                }
            }

        }

        MainMenuButton{
            id:help
            width: parent.width
            height: parent.height/4
            x:0
            y:parent.height/4 *3

            mainText:"Help"
            backgroundColor: "#d98af9"
            deselectedY: parent.height/4 *3
            shadowSize: parent.height/100
            imgSource: "qrc:/img/HelpBackground.png"
            imgOpacity: 0.15
            state:"deselected"

            z:0
            deselectedZ: 0

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(parent.state=="deselected")
                    {
                        helpOpenClicked()
                        statesToSelected()
                        parent.z=4
                    }
                    else
                    {
                        helpCloseClicked()
                        statesToDeselected()
                        resetZ()
                    }
                }
            }

        }

        /*Text{
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
*/





    }
