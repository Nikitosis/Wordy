import QtQuick 2.1
import QtQuick.Controls 1.0
import Qt.labs.folderlistmodel 2.1

Rectangle {
    id: fileBrowser
    //color: "transparent"
   // z: 4

    property string folderPath
    property bool shown: loader.sourceComponent
    property int itemHeight:parent.height/9
    property int itemWidth:parent.width
    property int scaledMargin:5
    property int fontSize:16
    property int animationDuration:250

    signal fileSelected(string file)

    function selectFile(file) {
        if (file !== "") {
            //folderPath = loader.item.folders.folder
            fileBrowser.fileSelected(file)
        }
        //loader.sourceComponent = undefined
    }

    function show() {
        loader.sourceComponent = fileBrowserComponent
        loader.item.parent = fileBrowser
        loader.item.anchors.fill = fileBrowser
        loader.item.foldersFolder = fileBrowser.folderPath
    }

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
                width: parent.width;
                height: itemHeight

                color: "transparent"

                Rectangle {
                    id: upButton
                    width: titleBar.height
                    height: titleBar.height
                    color: "transparent"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: scaledMargin

                    Image { anchors.fill: parent; anchors.margins: scaledMargin; source: "qrc:/img/HomeButton.png" }

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
                    anchors.left: upButton.right
                    anchors.right: parent.right
                    height: parent.height
                    anchors.leftMargin: 10
                    anchors.rightMargin: 4

                    text: folders.folder
                    color: textColor
                    elide: Text.ElideLeft; horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignVCenter
                    font.pixelSize:0
                }
            }

            Rectangle {                  //white line under titleBar
                color: "#353535"
                width: parent.width
                height: 1
                anchors.top: titleBar.bottom
            }

            Component {
                id: folderDelegate

                Rectangle {
                    id: wrapper

                    width: root.width
                    height: itemHeight
                    color: "transparent"


                    function launch() {                             //when we click on file,folder
                        var path = "file://";
                        if (filePath.length > 2 && filePath[1] === ':') // Windows drive logic, see QUrl::fromLocalFile()
                            path += '/';
                        path += filePath;
                        if (folders.isFolder(index))
                            down(path);
                        else
                            fileBrowser.selectFile(path)
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
                        onClicked: {
                            launch()
                            console.log("clicked")
                        }
                    }

                    states: [
                        State {
                            name: "pressed"
                            when: mouseRegion.pressed
                            PropertyChanges { target: wrapper; color: "grey" }
                        }
                    ]
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
