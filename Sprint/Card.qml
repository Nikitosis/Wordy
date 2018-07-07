import QtQuick 2.0

Flipable{
    id:card


    front:Rectangle{
            anchors.fill: parent
            color:"lightgreen"
            Text{
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap

                font.pixelSize: Math.min(parent.width/15,parent.height/3)

                text:word
            }
    }

    back:Rectangle{
        anchors.fill: parent
        color:"grey"
        Text{
            width: parent.width
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap

            font.pixelSize: Math.min(parent.width/15,parent.height/3)

            text:translation
        }
}

    transform: Rotation{
        id:rotate
        origin.x:card.width/2
        origin.y:card.height/2
        axis.x:1
        axis.y:0
        axis.z:0
        angle:0
    }


    states:[
            State{
                name:"rotated"
                PropertyChanges{
                    target:rotate
                    angle:0
                }
        },
            State{
                name:"default"
                PropertyChanges{
                    target:rotate
                    angle:180
            }
        }

    ]

    transitions: Transition{
        from:"default"
        to:"rotated"
        reversible: true
        NumberAnimation { target: rotate; property: "angle"; duration: 400 }
    }
}
