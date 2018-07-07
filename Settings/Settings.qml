import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id:mainBox

    property int        sectionHeigh:parent.height/5
    property color      sectionHeaderColor: "#dbbde6"

    Flickable
    {
        anchors.fill: parent
        interactive: true
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: column.height
        contentWidth: parent.width
        Column{
            id:column
            anchors.top: parent.top
            anchors.left: parent.left
            Rectangle{
                id:section1Header
                width: mainBox.width
                height: sectionHeigh
                color:sectionHeaderColor
                Text{
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: Math.min(parent.width/17,parent.height/4)
                    text:"First"
                }
            }
        }
    }

    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:mainBox
                opacity:0
                enabled:false
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:mainBox
                opacity:1
                enabled:true
            }
        }
    ]

    transitions: Transition{
        from:"closed"
        to:"opened"
        reversible: true

        NumberAnimation{
            properties: "opacity"
            duration: 600
        }
    }


}
