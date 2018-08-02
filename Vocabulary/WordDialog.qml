import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Rectangle{
    id:dialogWord

    color:"#71b4ec"


    signal accepted()
    signal cancel()

    property int maxWordLength: 30
    property alias newWordName: newWordName
    property alias newWordTranslation: newWordTranslation

    states:[
        State{
            name:"opened"
            PropertyChanges{
                target: dialogWord
                x:0
                enabled:true
            }
        },
        State{
            name:"closed"
            PropertyChanges{
                target: dialogWord
                x:-width
                enabled:false
            }
        }
    ]

    transitions: Transition{
        from:"closed"
        to:"opened"
        reversible: true

        NumberAnimation{
            properties: "x"
            duration:400
        }
    }

    Column{
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: parent.height/10

        spacing:parent.height/10

        Column{
            anchors.left: parent.left
            anchors.right: parent.right

            height: parent.height/5

            Text{
                id:newWordText
                anchors.margins: 5
                height: parent.height/2
                width: parent.width

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                text:qsTr("Word")
                color:"white"
                font.bold: true
            }
            Rectangle{
                id:newWordNameRec
                height: parent.height/2
                width: parent.width

                anchors.margins: 5

                color:"white"
                TextInput{
                    id:newWordName
                    anchors.fill: parent
                    font.pixelSize: Math.min(parent.height/1.6,width/length*1.9)
                    maximumLength: maxWordLength
                    onTextChanged: {
                        console.log("text changed")
                    }

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                }
            }
        }

        Column{
            width: parent.width
            height: parent.height/5

            Text{
                id:newWordTranslationText

                height: parent.height/2
                width: parent.width

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                text:qsTr("Definition")
                color:"white"
                font.bold: true
            }

            Rectangle{
                id:newWordTranslationRec

                height: parent.height/2
                width: parent.width

                color:"white"
                TextInput{
                    id:newWordTranslation
                    anchors.fill: parent
                    font.pixelSize: Math.min(parent.height/1.6,width/length*1.9)
                    maximumLength: maxWordLength

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter


                }
            }
        }
    }

    Button{
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height/7
        width: parent.width/3
        anchors.margins: 10
        Text{
            anchors.centerIn: parent
            text:qsTr("Apply")
            color:"black"
        }
        onClicked: {
            accepted()
            dialogWord.state="closed"
        }
    }

    Button{
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: parent.height/7
        width: parent.width/3
        anchors.margins: 10
        Text{
            anchors.centerIn: parent
            text:qsTr("Cancel")
            color:"black"
        }

        onClicked: {
            cancel()
            dialogWord.state="closed"
        }
    }

    MouseArea{                                          //background mouseArea to hide keyboard when click outside TextEdit
        anchors.fill: parent
        z:-1
        onClicked: {
            console.log("hide keyboard")
            Qt.inputMethod.hide()                      //hides keyboard
            newWordName.focus=false                    //removes the focus from TextEdits(get rid of blue triangle)
            newWordTranslation.focus=false
        }
    }

}
