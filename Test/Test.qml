import QtQuick 2.0

Rectangle {
    id:testBox

    property alias getCard: card
    color:"white"
    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:testBox
                opacity:0
                enabled:false
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:testBox
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

    TestCard{
        id:card
        anchors.fill: parent

        state:"start"

        onCloseWindow: { testBox.state="closed" }
    }


}
