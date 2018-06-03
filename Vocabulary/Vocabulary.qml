import QtQuick 2.0

Rectangle {
    id:vocabulary
    color: "white"

    Rectangle{
        id:banner
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: dictionary.height/5

        z:1
        color:"black"

        Text{
            anchors.centerIn: parent
            text:"Vocabulary"
            font.pixelSize: 20
            color:"white"
        }
    }

    VocabularyList{
        id:list
        anchors.top: banner.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        z:0
    }


    states:[
        State{
            name:"closed"
            PropertyChanges{
                target:dictionary
                x:-width
            }
        },
        State{
            name:"opened"
            PropertyChanges{
                target:dictionary
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

}
