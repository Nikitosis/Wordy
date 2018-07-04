import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.3
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

    DropShadow {
            id:shadow
            anchors.fill: parent
            cached: true
            horizontalOffset: 0
            verticalOffset: 2
            radius: 10
            samples: 16
            color: "#80000000"
            source: parent
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
               opacity:1
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
               opacity:0.25
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
