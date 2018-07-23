import QtQuick 2.1
import QtQuick.Controls 1.0
import Qt.labs.folderlistmodel 2.1

Rectangle {
    id: fileBrowser
    color: "transparent"
   // z: 4


    property string folderPath
    property bool shown: loader.sourceComponent
    property int itemHeight:parent.height/9
    property int itemWidth:parent.width
    property int scaledMargin:5
    property int fontSize:16
    property int animationDuration:250
    property string selectedFile:""

    signal acceptClicked(string file)

    function selectFile(file) {
        if (file !== "") {
            //fileBrowser.itemSelected(file)
            selectedFile=file
            console.log(selectedFile)
        }
    }

    function show() {
        loader.sourceComponent = fileBrowserComponent
        loader.item.parent = fileBrowser
        loader.item.anchors.fill = fileBrowser
        loader.item.foldersFolder = fileBrowser.folderPath
        //fileBrowser.state="opened"
    }

    function close()
    {
        loader.sourceComponent=undefined
        //fileBrowser.state="closed"
    }

    /*states:[
        State {
            name: "opened"
            PropertyChanges {
                target: fileBrowser
                x:0
            }
        },
        State {
            name: "closed"
            PropertyChanges {
                target: fileBrowser
                x:-fileBrowser.width
            }
        }
    ]

    transitions: Transition{
        NumberAnimation{ properties: "x"; duration: 1000 }
    }*/


    Loader {
        id: loader
    }

    Component {
        id: fileBrowserComponent

        Rectangle {
            id: root
            color: "white"

            property alias foldersFolder: folders.folder
            property color textColor: "black"


            Rectangle {
                id: titleBar
                width: root.width;
                height: itemHeight

                color: "transparent"
                Row{
                    width: parent.width
                    height: parent.height
                    Rectangle {
                        id: upButton
                        width: titleBar.height
                        height: titleBar.height
                        color: "transparent"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: scaledMargin

                        Image { anchors.fill: parent; anchors.margins: scaledMargin; source: "qrc:/img/BackButton.png" }

                        MouseArea { id: upRegion; anchors.fill: parent; onClicked: up() }

                        /*states: [
                        State {
                            name: "pressed"
                            when: upRegion.pressed
                            PropertyChanges { target: upButton; color: palette.highlight }
                        }
                    ]*/
                    }

                    Text {
                        id:textPath
                        height: parent.height
                        width: parent.width-parent.height*3

                        text: folders.folder
                        color: textColor
                        elide: Text.ElideLeft; horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignVCenter
                        font.pixelSize:0
                    }

                    Rectangle{
                        id:okButton
                        width: parent.height*2
                        height: parent.height
                        color:"green"

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                fileBrowser.acceptClicked("file:///"+selectedFile)
                                //fileBrowser.close()
                            }
                        }
                    }
                }


            }

            Rectangle {                  //white line under titleBar
                color: "#353535"
                width: root.width
                height: 1
                anchors.top: titleBar.bottom
            }

            Component {
                id: folderDelegate

                Rectangle {
                    id: wrapper

                    width: root.width
                    height: itemHeight
                    color: {
                        //console.log(filePath+" "+filePath==selectedFile)
                        return filePath==selectedFile ? "grey" :"transparent"

                    }


                    function launch() {                             //when we click on file,folder
                        var path = "file://";
                        if (filePath.length > 2 && filePath[1] === ':') // Windows drive logic, see QUrl::fromLocalFile()
                            path += '/';
                        path += filePath;

                        if (folders.isFolder(index))
                        {
                            down(path);
                        }
                    }
                    function select()
                    {
                        fileBrowser.selectFile(filePath)
                    }

                    Row{
                        width: root.width
                        height: itemHeight
                        Item {                                              //image before folder
                            width: itemHeight
                            height: itemHeight
                            Image {
                                id:itemImage
                                source: {
                                    if(folders.isFolder(index))
                                        return "qrc:/img/FolderIcon.png"
                                    else
                                        return "qrc:/img/DatabaseIcon.png"
                                }
                                fillMode: Image.PreserveAspectFit
                                anchors.fill: parent
                                anchors.margins: scaledMargin
                            }
                        }

                        Text {                                              //file or folder name
                            id: nameText
                            width: parent.width-itemHeight
                            height: parent.height
                            verticalAlignment: Text.AlignVCenter
                            //anchors.leftMargin: itemHeight + scaledMargin

                            text: fileName
                            font.pixelSize: 0
                            color:textColor

                            elide: Text.ElideRight
                        }
                    }

                    MouseArea {
                        id: mouseRegion
                        anchors.fill: parent
                        onDoubleClicked: {
                            launch()
                            console.log("clicked")
                        }
                        onClicked: {
                            select()
                        }
                    }

                    /*states: [
                        State {
                            name: "pressed"
                            when: mouseRegion.pressed
                            PropertyChanges { target: wrapper; color: "grey" }
                        },
                        State{
                            name:"selected"
                            when: filePath== selectedFile
                            PropertyChanges { target: wrapper; color: "blue" }
                        }

                    ]*/
                }
            }

            FolderListModel {
                id: folders
                folder: folderPath
                nameFilters: ["*.db"]
                sortField: "Type"
            }

            ListView {
                id: view

                anchors.top: titleBar.bottom
                anchors.bottom: parent.bottom

                width: parent.width
                clip:true

                model: folders
                delegate: folderDelegate

                focus: true
                state: "current"
                states: [
                    State {
                        name: "current"
                        PropertyChanges { target: view; x: 0 }
                    },
                    State {
                        name: "exitLeft"
                        PropertyChanges { target: view; x: -root.width }
                    },
                    State {
                        name: "exitRight"
                        PropertyChanges { target: view; x: root.width }
                    }
                ]
                transitions: [
                    Transition {
                        to:"current"
                        NumberAnimation { properties: "x"; duration: animationDuration ; easing.type: Easing.OutQuart}
                    },
                    Transition {
                        from:"current"
                        NumberAnimation { properties: "x"; duration: animationDuration ; easing.type: Easing.InQuart}
                    }

                ]
            }

            Timer{
                id:animationTimer
                interval: animationDuration
                running: false
                repeat: false
                property string path
                property int    startingX
                onTriggered: {
                    viewAppear(path,startingX)
                }
            }

            function viewAppear(path,startingX)
            {
                view.x = -root.width;

                folders.folder = path;
                view.state = "current";
            }

            function down(path) {
                view.state="exitLeft"

                animationTimer.path=path
                animationTimer.startingX=root.width

                animationTimer.start()
            }

            function up() {
                var path = folders.parentFolder;
                if (path.toString().length == 0 || path.toString() == 'file:')
                    return;

                view.state="exitRight"

                animationTimer.path=path
                animationTimer.startingX=-root.width

                animationTimer.start()
            }
        }
    }
}
