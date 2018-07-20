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
            mainMenu.statesToSelected()
            mainMenu.vocabulary.z=4

            vocabulary.open()
        }

        onSprintOpenClicked: {
            mainMenu.statesToSelected()
            mainMenu.sprint.z=4

            sprint.open()
        }
        onTestOpenClicked: {
            mainMenu.statesToSelected()
            mainMenu.test.z=4

            test.open()
        }

        onSettingsOpenClicked: {
            mainMenu.statesToSelected()
            mainMenu.settings.z=4

            settings.open()
        }

        onVocabularyCloseClicked: {
            mainMenu.statesToDeselected()
            mainMenu.resetZ()

            vocabulary.close()
        }

        onSprintCloseClicked: {
            mainMenu.statesToDeselected()
            mainMenu.resetZ()

            sprint.close()
        }

        onTestCloseClicked: {
            mainMenu.statesToDeselected()
            mainMenu.resetZ()

            test.close()
        }

        onSettingsCloseClicked: {
            mainMenu.statesToDeselected()
            mainMenu.resetZ()

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
