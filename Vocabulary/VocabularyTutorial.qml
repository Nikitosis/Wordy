import QtQuick 2.0

Item {
    id:mainBox

    property int buttonsHeight:height/8
    property int buttonsWidth:width/2
    property int pageNum:0
    Rectangle{
        id:background
        anchors.fill: parent
        z:-1
        color:"white"
        opacity: 1
    }
    MouseArea{
        anchors.fill: parent
    }

    Item{
        id:firstPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==0
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10


            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:"This is your vocabulary. Here you can add new words, change and delete them.\n
Each word belongs to pack.\n"
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: mainBox.height/10
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
            }

            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:"Words,which belong to first pack are new. You haven't repeated them in sprint yet."
            }
        }
    }

    Item{
        id:secondPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==1
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: mainBox.height/10
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
            }

            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:"Words go to the second pack, when you repeat them in Sprint for the first time."
            }
        }
    }

    Item{
        id:thirdPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==2
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: mainBox.height/10
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
            }

            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:"Words go to the third pack, when you repeat them in Sprint the next day after their first repeat."
            }
        }
    }


    Item{
        id:fourthPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==3
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: mainBox.height/10
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
            }

            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:"Words go to the fourth pack, when you repeat them in Sprint a week after their first repeat."
            }
        }
    }

    Item{
        id:fifthPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==4
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: mainBox.height/10
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducPassive.png"

                    fillMode: Image.PreserveAspectFit
                }
            }

            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:"Words go to the fifth pack, when you repeat them in Sprint in 2 weeks after their first repeat."
            }
        }
    }

    Item{
        id:sixthPage
        anchors.top: parent.top
        anchors.bottom: navigation.top
        anchors.left: parent.left
        anchors.right: parent.right
        visible: pageNum==5
        Column{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: 10

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: mainBox.height/10
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    width: mainBox.width/10
                    height: mainBox.height/10

                    source: "qrc:/img/EducActive.png"

                    fillMode: Image.PreserveAspectFit
                }
            }

            Text{
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter

                font.pixelSize: 15

                text:"Words go to the sixth pack, when you repeat them in Sprint in a month after their first repeat.\n
So that, you repeat each word 5 times in different periods of time. This way you will remember words for a very long time."
            }
        }
    }

    Row{
        id:navigation
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: buttonsHeight
        z:1


        Rectangle{
            id:skipButton
            width: buttonsWidth
            height: buttonsHeight

            Text{
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text:"Skip"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainBox.opacity=0
                    mainBox.enabled=false
                    tutorials.passVocabularyTutorial()
                }
            }
        }

        Rectangle{
            id:nextButton
            width: buttonsWidth
            height: buttonsHeight

            Text{
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text:"Next"
                font.bold: true
                color: "blue"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    pageNum=(pageNum+1)%6
                }
            }
        }
    }

    Behavior on opacity{
        NumberAnimation{duration: 150}
    }
}
