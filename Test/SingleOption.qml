import QtQuick 2.0

Rectangle{
    id:option
    property string text:""
    property bool isRight: false

    property color rightColor
    property color falseColor
    property color defaultColor
    signal singleOptionClicked()

    width:parent.width/2
    height: parent.height/2
    color:defaultColor

    Text{
        height: parent.height
        width: parent.width

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap

        text:option.text
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            option.color=option.isRight? rightColor : falseColor
            singleOptionClicked()
        }
    }

}
