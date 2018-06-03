import QtQuick 2.0
import QtQuick.Controls 2.0

Button{
    id:button
    property alias buttonText: buttonText


    background: Rectangle{
        id:backgroundRect
        anchors.fill: parent
        color:"black"
    }

    Text{
        id:buttonText
        anchors.centerIn: parent
        color:"white"
    }
}
