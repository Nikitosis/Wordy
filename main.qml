import QtQuick 2.6
import QtQuick.Window 2.2
import "./MainMenu"
import "./Vocabulary"



Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MainMenu{
        anchors.fill: parent

        onVocabularyClicked: {
            vocabulary.state="opened"
            console.log("dict")
        }
    }

    Vocabulary{
        id:vocabulary
        width: parent.width
        height: parent.height
        state:"closed"
    }

}
