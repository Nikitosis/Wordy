import QtQuick 2.0

Rectangle {
    id:sprint
    color:"white"
    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:sprint
                x:-width
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:sprint
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
    }


}