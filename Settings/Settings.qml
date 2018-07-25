import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0 as Platform

Rectangle {
    id:mainBox

    property int        sectionHeigh:parent.height/7
    property color      sectionHeaderColor: "#dbbde6"
    property color      sectionPropertyColor:"white"

    property int        wordsInPack:sprintModel.getWordsInPack()

    function open()
    {
        mainBox.state="opened"
        console.log("settings open")
    }

    function close()
    {
        mainBox.state="closed"
    }

    Flickable
    {
        anchors.fill: parent
        interactive: true
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: column.height
        contentWidth: parent.width
        Column{
            id:column
            anchors.top: parent.top
            anchors.left: parent.left
            Rectangle{
                id:section1Header
                width: mainBox.width
                height: sectionHeigh
                color:sectionHeaderColor
                Text{
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Math.min(parent.width/17,parent.height/4)
                    text:"Sprint settings"
                }
            }

            Rectangle{
                id:section1Property1

                width: mainBox.width
                height: sectionHeigh
                color:sectionPropertyColor

                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/20

                    width: parent.width*0.55
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: Math.min(section1Property1.width/16,section1Property1.height/4)
                    text:"Amount of new words to learn per day"
                    wrapMode: Text.Wrap
                }

                Row{
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width/20

                    width: parent.width*0.25
                    height: parent.height


                    Image{
                        height: parent.height
                        width: parent.width/4
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/img/ReducePropertyValue.jpg"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                wordsInPack--
                            }
                        }
                    }
                    Text{
                        height: parent.height
                        width: parent.width/2

                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                        font.pixelSize: Math.min(section1Property1.width/17,section1Property1.height/4)
                        text:wordsInPack
                    }
                    Image{
                        height: parent.height
                        width: parent.width/4
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/img/IncreasePropertyValue.jpg"

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                wordsInPack++
                            }
                        }
                    }

                }

            }

            Rectangle{
                id:section2Header
                width: mainBox.width
                height: sectionHeigh
                color:sectionHeaderColor
                Text{
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Math.min(parent.width/17,parent.height/4)
                    text:"Data settings"
                }
            }

            Rectangle{
                id:section2Property1

                width: mainBox.width
                height: sectionHeigh
                color:sectionPropertyColor

                Rectangle{
                    id:exportDatabase
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width/2

                    color:"blue"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            dialogBackground.state="opened"
                            exportDialog.show()
                        }
                    }
                }

                Rectangle{
                    id:importDatabase
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width/2
                    color:"green"
                    MouseArea{
                        anchors.fill: parent

                    }
                }

            }
        }
    }

    /*Rectangle{
        id:exportDialog
        visible: false
        color:"white"
        anchors.fill: parent
        ListView{
            id:list
            anchors.fill: parent



           model:fileSystemModel

            delegate: Rectangle{
                height: 50
                width: exportDialog.width
                Text{
                    anchors.centerIn: parent
                    text:fileName
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        list.i


                        console.log(index)
                    }
                }
            }
        }
    }*/

    Rectangle{
        id:dialogBackground
        anchors.fill: parent
        color:"black"
        opacity: 0
        enabled: false
        z:9

        signal backgroundClicked()

        state:"closed"

        Connections{
            target:exportDialog

            onCloseClick: dialogBackground.state="closed"
        }

        states:[
            State {
                name: "opened"
                PropertyChanges {
                    target: dialogBackground
                    opacity:0.3
                    enabled:true
                }
            },
            State{
                name:"closed"
                PropertyChanges {
                    target: dialogBackground
                    opacity:0
                    enabled:false
                }
            }

        ]
        transitions: Transition{
            NumberAnimation{properties: "opacity"; duration:400}
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                parent.state="closed"
                parent.backgroundClicked()
            }
        }
    }

    FileBrowser{
        id:exportDialog
        visible:true
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //anchors.left: parent.left
        width: parent.width/4*3
        clip:true

        z:10

        state:"closed"
        //folderPath:"file:///E:/"

        onFileChosen: {
           fileNameDialog.open()
        }

        onCloseClick: {
            state:"closed"
            close()
        }

        Connections{
            target: dialogBackground

            onBackgroundClicked:exportDialog.closeClick()
        }

        folderPath: Platform.StandardPaths.writableLocation(Platform.StandardPaths.HomeLocation)
        //folderPath:"file:///storage/extSdCard"

    }

    MessageDialog{
        id:fileNameDialog
        title:"Exporting database"
        text:"aaasadasdasd"
        height: parent.height/2
        width: parent.width/2

        standardButtons: StandardButton.Cancel | StandardButton.Apply

        /*Column{
            id:fileNameDialogColumn
            anchors.fill: parent
            Text{
                width: parent.width
                text:"abcsddsadasd"
                height: parent.height/3
            }
            TextField{
                width: parent.width
                height: parent.height/3
                font.pixelSize: 16
            }


        }
        /*Button{
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            text:"Apply"
            onClicked: fileNameDialog.Apply
        }
        Button{
            anchors.right: parent.right
            text:"Apply"
            onClicked: fileNameDialog.Apply
        }*/
        onApply: {

        }
    }


    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:mainBox
                opacity:0
                enabled:false
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:mainBox
                opacity:1
                enabled:true
            }
        }
    ]

    transitions: Transition{
        from:"closed"
        to:"opened"
        reversible: true

        NumberAnimation{
            properties: "opacity"
            duration: 600
        }
    }

    onStateChanged: {
        if(state=="closed")
        {
            sprintModel.setWordsInPack(wordsInPack)
        }
    }


}
