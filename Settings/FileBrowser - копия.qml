import QtQuick 2.1
import QtQuick.Controls 1.0
import Qt.labs.folderlistmodel 2.1

Rectangle {
    id: fileBrowser
    color: "transparent"
    // z: 4



    property string folderPath
    //property bool shown: loader.sourceComponent
    property int itemHeight:parent.height/9
    property int itemWidth:parent.width
    property int scaledMargin:5
    property int fontSize:16
    property int animationDuration:250
    property string selectedFile:""

    signal fileChosen(string file)
    signal closeClick()

    function selectFile(file) {
        if (file !== "") {
            //fileBrowser.itemSelected(file)
            selectedFile=file
            console.log(selectedFile)
        }
    }

    function show() {
        //loader.sourceComponent = fileBrowserComponent
        //loader.item.parent = fileBrowser
        //loader.item.anchors.fill = fileBrowser
        root.foldersFolder = fileBrowser.folderPath
        fileBrowser.state="opened"
    }

    function close()
    {
        //loader.sourceComponent=undefined
        fileBrowser.state="closed"
        console.log("close")
    }

    states:[
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
        NumberAnimation{ properties: "x"; duration: 400; easing.type:Easing.OutCubic  }
    }

    Rectangle {
        id: root
        color: "white"
        anchors.fill: parent

        property alias foldersFolder: folders.folder
        property color textColor: "black"


        Rectangle {
            id: titleBar
            width: root.width;
            height: itemHeight+itemHeight/2

            color: "transparent"
            Column{
                anchors.left: parent.left
                anchors.top: parent.top
                width: parent.width
                height: parent.height
                Item{
                    id:navigationButtons
                    width: parent.width
                    height: itemHeight

                    Rectangle {
                        id: closeButton
                        width: Math.min(parent.height,parent.width/3)
                        height: parent.height

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: scaledMargin
                        anchors.left: parent.left

                        color: "transparent"

                        Image { anchors.fill: parent; anchors.margins: scaledMargin; source: "qrc:/img/BackButton.png" }

                        MouseArea {anchors.fill: parent; onClicked: closeClick() }

                        /*states: [
                        State {
                            name: "pressed"
                            when: upRegion.pressed
                            PropertyChanges { target: upButton; color: palette.highlight }
                        }
                    ]*/
                    }

                    Rectangle {
                        id: upButton
                        width: Math.min(parent.height,parent.width/3)
                        height: parent.height

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: scaledMargin
                        anchors.left: closeButton.right

                        color: "transparent"

                        Image { anchors.fill: parent; anchors.margins: scaledMargin; source: "qrc:/img/UpFolderIcon.png" }

                        MouseArea { anchors.fill: parent; onClicked: root.upDir() }

                        /*states: [
                        State {
                            name: "pressed"
                            when: upRegion.pressed
                            PropertyChanges { target: upButton; color: palette.highlight }
                        }
                    ]*/
                    }

                    Rectangle{
                        id:okButton

                        property color disabledColor:"#80b57a"
                        property color enabledColor:"green"

                        anchors.right: parent.right
                        anchors.top: parent.top

                        width:Math.min(parent.height*2,parent.width/3)
                        height: parent.height
                        color:selectedFile!="" ? enabledColor : disabledColor

                       // enabled: selectedFile!="" ? true : false

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                fileBrowser.fileChosen("file:///"+selectedFile)
                                //fileBrowser.close()
                            }
                        }
                    }
                }
                Rectangle {                  //black line under navigationButtons
                    color: "#353535"
                    width: root.width
                    height: 1
                }

                Text {
                    id:textPath
                    height: itemHeight/2
                    width: parent.width
                    anchors.left: parent.left

                    text: folders.folder
                    color: root.textColor
                    elide: Text.ElideLeft; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                    font.pixelSize:0
                }
            }


        }

        Rectangle {                  //black line under titleBar
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
                color: filePath==selectedFile ? "grey" :"transparent"

                function launch() {                             //when we click on file,folder
                    var path = "file://";
                    if (filePath.length > 2 && filePath[1] === ':') // Windows drive logic, see QUrl::fromLocalFile()
                        path += '/';
                    path += filePath;

                    if (folders.isFolder(index))
                    {
                        root.downDir(path);
                        console.log("updir")
                    }

                    selectedFile=""
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
                        color:root.textColor

                        elide: Text.ElideRight
                    }
                }

                MouseArea {
                    id: mouseRegion
                    anchors.fill: parent
                    onDoubleClicked: {
                        launch()
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
                root.viewAppear(path,startingX)
            }
        }

        function viewAppear(path,startingX)
        {
            view.x = -root.width;

            folders.folder = path;
            view.state = "current";
        }

        function downDir(path) {
            view.state="exitLeft"

            animationTimer.path=path
            animationTimer.startingX=root.width

            animationTimer.start()
        }

        function upDir() {
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
