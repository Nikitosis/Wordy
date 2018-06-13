import QtQuick 2.6
import QtQuick.Window 2.2
import "./MainMenu"
import "./Vocabulary"
import "./Sprint"
import "./Test"



Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    /*MainMenu{
        anchors.fill: parent
        z:0

        onVocabularyClicked: {
            vocabulary.state="opened"
            console.log("Vocabulary opened")
            myModel.updateModel()
        }

        onSprintClicked: {
            sprintModel.updateModel()
            sprint.state="opened"
            console.log("Sprint opened")
        }
    }*/

    Vocabulary{
        id:vocabulary
        width: parent.width
        height: parent.height
        state:"closed"
        z:1
    }

    Sprint{
        id:sprint
        width: parent.width
        height: parent.height
        state:"closed"
        z:1
    }

    Rectangle{
        id:test
        anchors.fill: parent
        z:1
        color:"black"
    }

}
