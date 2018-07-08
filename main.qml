import QtQuick 2.6
import QtQuick.Window 2.2
import "./MainMenu"
import "./Vocabulary"
import "./Sprint"
import "./Test"
import "./Settings"



Window {
    id:window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MainMenu{
        id:mainMenu
        anchors.fill: parent
        z:1

        onVocabularyOpenClicked: {
            vocabulary.state="opened"
            vocabulary.list.listView.currentIndex=-1                //open vocabulary without selected item
            console.log("Vocabulary opened")
            myModel.updateModel()
        }

        onSprintOpenClicked: {
            sprint.state="opened"
            console.log("Sprint opened aaa")
            sprintModel.updateModel()
        }
        onTestOpenClicked: {
            test.state="opened"
            console.log("test opened")
            test.getCard.state="start"
        }

        onSettingsOpenClicked: {
            settings.state="opened"
            console.log("settings open")
        }

        onVocabularyCloseClicked: {
            vocabulary.state="closed"
            vocabulary.dialogNewWord.state="closed"
            vocabulary.dialogUpdateWord.state="closed"
        }

        onSprintCloseClicked: {
            sprint.state="closed"
        }

        onTestCloseClicked: {
            test.state="closed"
        }

        onSettingsCloseClicked: {
            settings.state="closed"
        }
    }

    Vocabulary{
        id:vocabulary
        anchors.bottom:parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height:parent.height/9 *8

        state:"closed"
        z:0
    }

    Sprint{
        id:sprint

        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height/9 *8

        state:"closed"
        z:0
    }

    Test{
        id:test

        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height/9 *8

        z:0

        state:"closed"
    }

    Settings{
        id:settings

        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height/9 *8

        z:0

        state:"closed"
    }

}
