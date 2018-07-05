import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id:box
    property color   backgroundColor
    property string  mainText
    property string  imgsource
    property int     selectedHeight:parent.height/9
    property int     deselectedHeight:parent.height/4
    property int     deselectedY
    property int     deselectedZ
    property int     animationDuration:900
    property int     shadowSize


    color:backgroundColor

    Text
    {
        id:textLabel
        anchors.centerIn: parent
        font.pixelSize: 25
        text:mainText
        color:"white"
        font.bold: true
    }

    /*DropShadow {
            id:shadow
            anchors.fill: parent
            cached: true
            horizontalOffset: 0
            verticalOffset: 2
            radius: 7
            samples: 7
            color: "#80000000"
            source: parent
   }*/
    Rectangle {
                id: shadow
                property real offset: shadowSize

                color: "black"
                width: parent.width
                height: parent.height
                z: -1
                opacity: 0.25
                radius: parent.radius
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: offset
            }

   states:[
       State{
           name:"deselected"
           PropertyChanges {
               target: box
               height:deselectedHeight
               y:deselectedY
           }
           PropertyChanges{
               target: shadow
               opacity:0.10
           }
       },
       State{
           name:"selected"
           PropertyChanges{
               target:box
               height:selectedHeight
               y:0
           }
           PropertyChanges{
               target: shadow
               opacity:0.03
           }
       }
   ]

   transitions: [
       Transition {
           from: "deselected"
           to: "selected"

           NumberAnimation{
               properties: "height,y,opacity"
               duration: animationDuration
               easing.type: Easing.OutExpo
           }
       },
       Transition {
           from: "selected"
           to: "deselected"

           NumberAnimation{
               properties: "height,y,opacity"
               duration: animationDuration
               easing.type: Easing.OutExpo
           }
       }

   ]

}
