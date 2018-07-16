import QtQuick 2.0

Item {
    id:mainBox

    property int buttonsHeight:height/8
    property int buttonsWidth:width/4
    Rectangle{
        id:background
        anchors.fill: parent
        z:-1
        color:"white"
        opacity: 1
    }
    MouseArea{
        anchors.fill: parent
    }

    Row{
        id:firstPage
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:parent.top
        anchors.topMargin: 10

        height: parent.height-buttonsHeight-anchors.topMargin


        Text{
            width: parent.width
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: 15

            text:"This is your vocabulary. Here you can add new words, change and delete them."
        }

    }

    Row{
        id:navigation
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: buttonsHeight
        z:1



        Rectangle{
            id:nextButton
            width: buttonsWidth
            height: buttonsHeight
            color:"red"
        }

        Rectangle{
            id:skipButton
            width: buttonsWidth
            height: buttonsHeight
            color:"blue"
        }
    }
}
