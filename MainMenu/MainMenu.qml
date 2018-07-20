import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

    Item{
        id:main
        signal vocabularyOpenClicked()
        signal sprintOpenClicked()
        signal testOpenClicked()
        signal settingsOpenClicked()

        signal vocabularyCloseClicked()
        signal sprintCloseClicked()
        signal testCloseClicked()
        signal settingsCloseClicked()

        property alias vocabulary:vocabulary
        property alias sprint:sprint
        property alias test:test
        property alias settings:settings


        function statesToSelected()
        {
            vocabulary.state="selected"
            sprint.state="selected"
            test.state="selected"
            settings.state="selected"
        }

        function statesToDeselected()
        {
            vocabulary.state="deselected"
            sprint.state="deselected"
            test.state="deselected"
            settings.state="deselected"
        }

        function resetZ()
        {
            vocabulary.z=3
            sprint.z=2
            test.z=1
            settings.z=0
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
                    }
                    else
                    {
                        vocabularyCloseClicked()
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
                    }
                    else
                    {
                        sprintCloseClicked()
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
                    }
                    else
                    {
                        testCloseClicked()
                    }
                }
            }

        }

        MainMenuButton{
            id:settings
            width: parent.width
            height: parent.height/4
            x:0
            y:parent.height/4 *3

            mainText:"Settings"
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
                        settingsOpenClicked()
                    }
                    else
                    {
                        settingsCloseClicked()
                    }
                }
            }

        }

    }
