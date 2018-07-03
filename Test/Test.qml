import QtQuick 2.0

Rectangle {
    id:testBox
    color:"white"
    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:testBox
                x:-width
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:testBox
                x:0
            }
        }
    ]

    transitions: Transition{
        from:"closed"
        to:"opened"
        reversible: true

        NumberAnimation{
            properties: "x"
            duration: 500
        }
    }

    TestCard{
        id:card
        anchors.fill: parent

        onCloseWindow: { testBox.state="closed" }
    }


}
