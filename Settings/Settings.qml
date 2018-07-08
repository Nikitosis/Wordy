import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id:mainBox

    property int        sectionHeigh:parent.height/7
    property color      sectionHeaderColor: "#dbbde6"
    property color      sectionPropertyColor:"white"

    property int        wordsInPack:sprintModel.getWordsInPack()

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
                    text:"Sprint settings"
                }
            }

            Rectangle{
                id:section1Property1

                width: mainBox.width
                height: sectionHeigh
                color:sectionPropertyColor

                Text{
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/20

                    width: parent.width*0.55
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: Math.min(section1Property1.width/16,section1Property1.height/4)
                    text:"Amount of new words to learn per day"
                    wrapMode: Text.Wrap
                }

                Row{
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width/20

                    width: parent.width*0.25
                    height: parent.height


                    Image{
                        height: parent.height
                        width: parent.width/4
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/img/ReducePropertyValue.jpg"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                wordsInPack--
                            }
                        }
                    }
                    Text{
                        height: parent.height
                        width: parent.width/2

                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                        font.pixelSize: Math.min(section1Property1.width/17,section1Property1.height/4)
                        text:wordsInPack
                    }
                    Image{
                        height: parent.height
                        width: parent.width/4
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/img/IncreasePropertyValue.jpg"

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                wordsInPack++
                            }
                        }
                    }

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

    onStateChanged: {
        if(state=="closed")
        {
            sprintModel.setWordsInPack(wordsInPack)
        }
    }


}
