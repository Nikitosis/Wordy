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
        loader.item.folders1Folder = fileBrowser.folderPath
    }

    Loader {
        id: loader
    }

    Component {
        id: fileBrowserComponent

        Rectangle {
            id: root
            color: "white"

            property variant currentFolder: folders1
            property variant currentView: view1
            property alias folders1Folder: folders1.folder
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

                    states: [
                        State {
                            name: "pressed"
                            when: upRegion.pressed
                            PropertyChanges { target: upButton; color: palette.highlight }
                        }
                    ]
                }

                Text {
                    anchors.left: upButton.right
                    anchors.right: parent.right
                    height: parent.height
                    anchors.leftMargin: 10
                    anchors.rightMargin: 4

                    text: currentFolder.folder
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

            FolderListModel {
                id: folders1
                folder: folderPath
                nameFilters: ["*.db"]
                sortField: "Type"
            }

            FolderListModel {
                id: folders2
                folder: folderPath
                nameFilters: ["*.db"]
                sortField: "Type"
            }

            SystemPalette {
                id: palette
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
                        if (currentFolder.isFolder(index))
                            down(path);
                        else
                            fileBrowser.selectFile(path)
                    }

                    function updateImage()
                    {
                        if(currentFolder.isFolder(index))
                            itemImage.source= "qrc:/img/FolderIcon.png"
                        else
                            itemImage.source= "qrc:/img/DatabaseIcon.png"
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
                                    if(view1.tellIsFolder(index))
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
                            if (currentFolder == currentView.model) launch()
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

            ListView {
                id: view1

                property bool canUpdateImage:true
                function tellIsFolder(index)
                {
                    return folders1.isFolder(index)
                }

                anchors.top: titleBar.bottom
                anchors.bottom: parent.bottom

                width: parent.width
                clip:true

                model: folders1
                delegate: folderDelegate

                focus: true
                state: "current"
                states: [
                    State {
                        name: "current"
                        PropertyChanges { target: view1; x: 0 }
                    },
                    State {
                        name: "exitLeft"
                        PropertyChanges { target: view1; x: -root.width }
                    },
                    State {
                        name: "exitRight"
                        PropertyChanges { target: view1; x: root.width }
                    }
                ]
                transitions: [
                    Transition {
                        NumberAnimation { properties: "x"; duration: 450 }
                    }
                ]
            }

            ListView {
                id: view2

                property bool canUpdateImage:true
                function tellIsFolder(index)
                {
                    return folders2.isFolder(index)
                }

                anchors.top: titleBar.bottom
                anchors.bottom: parent.bottom

                width: parent.width
                clip:true

                model: folders2
                delegate: folderDelegate

                state:"exitRight"
                states: [
                    State {
                        name: "current"
                        PropertyChanges { target: view2; x: 0 }
                    },
                    State {
                        name: "exitLeft"
                        PropertyChanges { target: view2; x: -root.width }
                    },
                    State {
                        name: "exitRight"
                        PropertyChanges { target: view2; x: root.width }
                    }
                ]
                transitions: [
                    Transition {
                        NumberAnimation { properties: "x"; duration: 450 }
                    }
                ]
            }

            function down(path) {
                if (currentFolder == folders1) {
                    currentView = view2
                    currentFolder = folders2;
                    view1.state = "exitLeft";
                } else {
                    currentView = view1
                    currentFolder = folders1;
                    view2.state = "exitLeft";
                }
                currentView.x = root.width;
                currentView.focus = true;
                currentFolder.folder = path;
                currentView.state = "current";
            }

            function up() {
                var path = currentFolder.parentFolder;
                if (path.toString().length == 0 || path.toString() == 'file:')
                    return;
                if (currentFolder == folders1) {
                    currentView = view2
                    currentFolder = folders2;
                    view1.state = "exitRight";
                } else {
                    currentView = view1
                    currentFolder = folders1;
                    view2.state = "exitRight";
                }
                currentView.x = -root.width;
                currentView.focus = true;
                currentFolder.folder = path;
                currentView.state = "current";
            }
        }
    }
}
