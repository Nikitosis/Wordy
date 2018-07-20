import QtQuick 2.0

Rectangle {
    id:testBox

    color:"white"

    property alias getCard: card
    function open()
    {
        testBox.state="opened"
        console.log("test opened")
        card.state="start"
    }

    function close()
    {
        testBox.state="closed"
    }

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
