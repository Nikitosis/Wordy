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

    signal folderChosen(string folderPath)
    signal closeClick()

    function show() {
        //loader.sourceComponent = fileBrowserComponent
        //loader.item.parent = fileBrowser
        //loader.item.anchors.fill = fileBrowser
        //folders.folder = fileBrowser.folderPath
        root.curModel=driveListModel
        fileBrowser.state="opened"

        console.log("show ExportBrowse")
    }

    function close()
    {
        //loader.sourceComponent=undefined
        fileBrowser.state="closed"
        console.log("close ExportBrowser")
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

    MouseArea{                     //to not let background catch clicks
        anchors.fill: parent
    }

    Rectangle {
        id: root
        color: "white"
        anchors.fill: parent

        property color textColor: "black"
        readonly property string rootFolder:"file:///"
        property var curModel:driveListModel


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

                        color: closeButtonMouseArea.pressed ? "#dcdcdc" : "transparent"

                        Image { anchors.fill: parent; anchors.margins: scaledMargin; source: "qrc:/img/BackButton.png" }

                        MouseArea {
                            id:closeButtonMouseArea
                            anchors.fill: parent
                            onClicked: closeClick()
                        }

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

                        color:upButtonMouseArea.pressed ? "#dcdcdc" : "transparent"

                        Image { anchors.fill: parent; anchors.margins: scaledMargin; source: "qrc:/img/UpFolderIcon.png" }

                        MouseArea {
                            id:upButtonMouseArea
                            anchors.fill: parent
                            onClicked: root.upDir()
                        }

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

                        anchors.right: parent.right
                        anchors.top: parent.top

                        width:Math.min(parent.height*2,parent.width/3)
                        height: parent.height
                        color:enabled ? "#329dcf" : "#8faebd"

                        enabled: {
                            if(root.curModel==driveListModel)
                                return false
                            return true
                        }

                        Text{
                            anchors.fill: parent

                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            text:"Choose folder"
                            wrapMode: Text.Wrap
                        }


                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                fileBrowser.folderChosen(foldersModel.folder)
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

                    text: foldersModel.folder
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
                color: view.currentIndex==index ? "grey" :"transparent"

                function launch() {                             //when we click on file,folder
                    var path = "file://";
                    if (filePath.length > 2 && filePath[1] === ':') // Windows drive logic, see QUrl::fromLocalFile()
                        path += '/';
                    path += filePath;

                    if (foldersModel.isFolder(index) || root.curModel==driveListModel)
                    {
                        root.downDir(path);
                        console.log("updir")
                    }
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
                                if(root.curModel==driveListModel)
                                    return "qrc:/img/FolderIcon.png"

                                if(foldersModel.isFolder(index))
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
                        view.currentIndex=index
                    }
                }
            }
        }

        FolderListModel {
            id: foldersModel
            folder: folderPath
            nameFilters: ["*.db"]
            sortField: "Type"
        }

        //FolderListModel has one issue: it can't show folders. So to fix this, I implemented ListModel special for drives
        //view's model is root.curModel. So I can assign root.curModel to driveListModel or foldersModel if I want
        //so if user wants to go from the drive, root.curModel=driveListModel, hence drives are shown
        //if user goes into drive, root.curModel=foldersModel,hence folders are shown
        ListModel{
            id:driveListModel


            Component.onCompleted: initialize()

            function initialize() {

                var count = myDrives.getDrives().length;

                var drive;
                for (var i = 0; i < count; i++) {
                    drive = myDrives.getDrives()[i].slice(0, -1);  // Remove trailing "/".
                    append({
                               fileName: drive,
                               fileModified: new Date(0),
                               fileSize: 0,
                               filePath: drive + "/",
                               fileIsDir: true,
                               fileNameSort: drive.toLowerCase()
                           });
                    console.log("Drive added:",drive)
                }
            }

            function getItem(index, field) {
                return get(index)[field];
            }
        }

        ListView {
            id: view

            anchors.top: titleBar.bottom
            anchors.bottom: parent.bottom

            width: parent.width
            clip:true

            model: root.curModel
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

            if(path===root.rootFolder || path==="")    //if we pressed upButton in the root of the drive,we go to drives
                root.curModel=driveListModel
            else
                root.curModel=foldersModel

            if(root.curModel==foldersModel)
                foldersModel.folder = path;

            view.state = "current";
        }

        function downDir(path) {
            view.state="exitLeft"

            animationTimer.path=path
            animationTimer.startingX=root.width

            view.currentIndex=-1

            animationTimer.start()
        }

        function upDir() {
            if(root.curModel==driveListModel)
                return;

            var path = foldersModel.parentFolder;

            view.state="exitRight"

            view.currentIndex=-1

            animationTimer.path=path
            animationTimer.startingX=-root.width

            animationTimer.start()

        }
    }
}
