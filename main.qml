import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
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
            vocabulary.open()
        }

        onSprintOpenClicked: {
            sprint.open()
        }
        onTestOpenClicked: {
            test.open()
        }

        onSettingsOpenClicked: {
            settings.open()
        }

        onVocabularyCloseClicked: {
            vocabulary.close()
        }

        onSprintCloseClicked: {
            sprint.close()
        }

        onTestCloseClicked: {
            test.close()
        }

        onSettingsCloseClicked: {
            settings.close()
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
