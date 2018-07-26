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
                            exportBrowser.show()
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
                        onClicked: {
                            dialogBackground.state="opened"
                            importBrowser.show()
                        }
                    }
                }

            }
        }
    }

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
            target:exportBrowser

            onCloseClick: dialogBackground.state="closed"
        }

        Connections{
            target: importBrowser

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
    ImportBrowser{
        id:importBrowser
        visible:true
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //anchors.left: parent.left
        width: parent.width/4*3
        clip:true

        z:10

        state:"closed"

        onFileChosen: {
           console.log(selectedFile)
           acceptImport.open()
        }

        onCloseClick: {
            state:"closed"
            close()
        }

        Connections{
            target: dialogBackground

            onBackgroundClicked:importBrowser.closeClick()
        }

        folderPath: Platform.StandardPaths.writableLocation(Platform.StandardPaths.HomeLocation)
    }

    Item{                          //imports database
        id:importer

        property string selectedFile: importBrowser.selectedFile

        Connections{
            target:acceptImport

            onApply: {

                var correctFilePath=importer.selectedFile
                if(correctFilePath[9]===":")              //getting rid of file:///
                    correctFilePath=importer.selectedFile.slice(8)
                else
                    correctFilePath=importer.selectedFile.slice(7)

                if(database.importDatabase(correctFilePath))
                {
                    messageDialog.text="succesfully loaded"
                }
                else
                {
                    messageDialog.text="error loading database"
                }

                messageDialog.open()
            }
        }
    }

    MessageDialog {
        id: acceptImport
        title: "Warning"
        text:"Do you want to load chosen database? You will lose current one."
        standardButtons: StandardButton.Apply | StandardButton.Cancel
    }

    ExportBrowser{
        id:exportBrowser
        visible:true
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //anchors.left: parent.left
        width: parent.width/4*3
        clip:true

        z:10

        state:"closed"
        //folderPath:"file:///E:/"

        onFolderChosen: {
           console.log("fileChosen",folderPath)
           saveDialog.openAndInit(folderPath)
        }

        onCloseClick: {
            state:"closed"
            close()
        }

        Connections{
            target: dialogBackground

            onBackgroundClicked:exportBrowser.closeClick()
        }

        folderPath: Platform.StandardPaths.writableLocation(Platform.StandardPaths.HomeLocation)
    }

    Item{                    //exports Database
        id:exporter

        property string fileName
        property string folderPath
        function tryExportDatabase(newFolderPath,newFileName)
        {
            folderPath=newFolderPath
            fileName=newFileName

            var correctFilePath=folderPath

            if(correctFilePath[9]===":")              //if using windows file system
                correctFilePath=correctFilePath.slice(8)
            else
                correctFilePath=correctFilePath.slice(7)

            console.log(correctFilePath)

            if(database.isFileExist(correctFilePath,fileName+".db"))
            {
                acceptReplaceDialog.open()
            }
            else
            {
                exporter.exportDatabase()
            }
        }

        function exportDatabase()
        {
            var correctFilePath=folderPath

            if(correctFilePath[9]===":")              //if using windows file system
                correctFilePath=correctFilePath.slice(8)
            else
                correctFilePath=correctFilePath.slice(7)

            console.log("exportDb")

           if(database.exportDatabase(correctFilePath,fileName+".db"))
           {
               messageDialog.text="Succesfully copied"
           }
           else
           {
              messageDialog.text="Error copying database"
           }
           messageDialog.open()
        }

        Connections{
            target: acceptReplaceDialog

            onApply: exporter.exportDatabase()
        }

        Connections{
            target:saveDialog

            onApply: {
                exporter.tryExportDatabase(saveDialog.path,saveDialog.fileName)
            }
        }

    }

    SaveDialog{
        id:saveDialog
        dialogWidth:parent.width/4*3
        dialogHeight: parent.height/4*3

        function openAndInit(newpath)
        {
            path=newpath
            saveDialog.open()
        }
    }

    MessageDialog {
        id: acceptReplaceDialog
        title: "Warning"
        text:"Database with this name already exists. Do you want to replace it?"
        standardButtons: StandardButton.Apply | StandardButton.Cancel
    }


    MessageDialog{
        id:messageDialog
        title:"Information"
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
