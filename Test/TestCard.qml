import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.2

Rectangle {
    id:main
    color:"#dbeff4"

    property string rightColor:"#689a6b"
    property string wrongColor:"#9a7568"
    property string defaultColor: "#5e757d"
    property int    animationDuration: 500
    property int    startBannerAnimationDuration:500
    property int    fromPackNum:1
    property int    toPackNum:5

    signal closeWindow()

    function changeCard()
    {
        nextButton.enabled=false
        changeCardAnimation.start()
        //nextButton.enabled=false
    }

    function initCard()
    {
        testInfo.newTest(fromPackNum,toPackNum)

        firstOption.text=testInfo.getOption(0)
        secondOption.text=testInfo.getOption(1)
        thirdOption.text=testInfo.getOption(2)
        fourthOption.text=testInfo.getOption(3)

        if(firstOption.text==testInfo.getMainAnsver())
            firstOption.isRight=true
        else
            firstOption.isRight=false

        if(secondOption.text==testInfo.getMainAnsver())
            secondOption.isRight=true
        else
            secondOption.isRight=false

        if(thirdOption.text==testInfo.getMainAnsver())
            thirdOption.isRight=true
        else
            thirdOption.isRight=false

        if(fourthOption.text==testInfo.getMainAnsver())
            fourthOption.isRight=true
        else
            fourthOption.isRight=false

        mainWordText.text=testInfo.getMainWord()

        nextButton.enabled=false

        firstOption.enabled=true
        secondOption.enabled=true
        thirdOption.enabled=true
        fourthOption.enabled=true

        firstOption.color=defaultColor
        secondOption.color=defaultColor
        thirdOption.color=defaultColor
        fourthOption.color=defaultColor


        console.log("init card")
    }

    function optionClicked()
    {
        if(firstOption.text==testInfo.getMainAnsver())
        {
            firstOption.color=rightColor
        }
        if(secondOption.text==testInfo.getMainAnsver())
        {
            secondOption.color=rightColor
        }
        if(thirdOption.text==testInfo.getMainAnsver())
        {
            thirdOption.color=rightColor
        }
        if(fourthOption.text==testInfo.getMainAnsver())
        {
            fourthOption.color=rightColor
        }

        nextButton.enabled=true

        firstOption.enabled=false
        secondOption.enabled=false
        thirdOption.enabled=false
        fourthOption.enabled=false

    }

    Rectangle{
        id:startingBanner
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        color:"transparent"

        z:2

        Text{
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: packChoosing.top
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            text:qsTr("Start")
            font.pixelSize: width/5

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    fromPackNum=fromPack.rating
                    toPackNum=toPack.rating

                    if(testInfo.canBuildTest(fromPackNum,toPackNum))
                    {
                        main.state="test"
                        initCard()
                    }
                    else
                    {
                        warningDialog.open()
                    }
                }
            }
        }

        Rectangle{
            id:packChoosing
            anchors.left: parent.left
            anchors.right:parent.right
            anchors.bottom: parent.bottom
            height: parent.height/6
            color:"grey"
            Row{
                anchors.fill: parent
                TestPackRating{
                    id:fromPack
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    width: parent.width/3
                    rating:1
                }

                Item{
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width/3

                    Text{
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap

                        text:qsTr("Only words between")
                        font.pixelSize: Math.max(15,width/16)
                    }
                }

                TestPackRating{
                    id:toPack
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    width: parent.width/3
                    rating: 6
                }
            }
        }
    }

    Rectangle{
        id:mainWordBox
        anchors.top: parent.top
        height: parent.height/6
        width: parent.width

        color:"transparent"


        Text{
            id:mainWordText
            height: parent.height
            width: parent.width

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: Math.min(parent.width/15,parent.height/3)
            wrapMode: Text.Wrap
            font.bold: true

        }
    }

    Item{
        id:optionsBox

        anchors.top: mainWordBox.bottom
        anchors.bottom: nextButton.top

        width:parent.width

        Rectangle{
            id:firstOption
            property string text:""
            property bool isRight: false
            anchors.left: parent.left
            anchors.top: parent.top
            width:parent.width/2
            height: parent.height/2
            color:defaultColor

            Text{
                height: parent.height
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: Math.min(parent.width/18,parent.height/4)

                color:"white"

                text:firstOption.text
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    firstOption.color=firstOption.isRight? rightColor : wrongColor
                    optionClicked()
                }
            }

        }

        Rectangle{
            id:secondOption
            property string text:""
            property bool isRight: false
            anchors.right: parent.right
            anchors.top: parent.top
            width:parent.width/2
            height: parent.height/2
            color:defaultColor

            Text{
                height: parent.height
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: Math.min(parent.width/18,parent.height/4)

                color:"white"

                text:secondOption.text
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    secondOption.color=secondOption.isRight? rightColor : wrongColor
                    optionClicked()
                }
            }

        }
        Rectangle{
            id:thirdOption
            property string text:""
            property bool isRight: false
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width:parent.width/2
            height: parent.height/2
            color:defaultColor

            Text{
                height: parent.height
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: Math.min(parent.width/18,parent.height/4)

                color:"white"

                text:thirdOption.text
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    thirdOption.color=thirdOption.isRight? rightColor : wrongColor
                    optionClicked()
                }
            }

        }
        Rectangle{
            id:fourthOption
            property string text:""
            property bool isRight: false
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width:parent.width/2
            height: parent.height/2
            color:defaultColor

            Text{
                height: parent.height
                width: parent.width

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: Math.min(parent.width/18,parent.height/4)

                color:"white"

                text:fourthOption.text
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    fourthOption.color=fourthOption.isRight? rightColor : wrongColor
                    optionClicked()
                }
            }

        }

    }

    Rectangle{
        id:nextButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height/6
        z:1

        color:enabled ? "#41819b" : "#9cbdcb"

        Image{
            anchors.centerIn: parent
            width: parent.width
            height: parent.height-parent.height/10
            source: nextButton.enabled ? "qrc:/img/NextTestActive.png" : "qrc:/img/NextTestPassive.png"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                changeCard()
            }
        }

        Behavior on color{
            ColorAnimation{duration:200}
        }
    }

    MessageDialog{
        id:warningDialog
        title: "Warning"
        text:qsTr("You can't run test,because there are less then 4 words in the vocabulary,which correspond to the selected pack range.")

    }

    Timer{                               //timer to update card in the middle of card changing
        id:animationTimer
        interval: animationDuration
        repeat: false
        running: false
        onTriggered: {
            initCard()
            console.log("inited")
        }
    }

    SequentialAnimation{               //card changing animation
        id:changeCardAnimation

        onStarted: {
            console.log("started")
            animationTimer.start()     //count animationDuration, then update card
        }
        onStopped: {
            console.log("stopped")
        }

        ParallelAnimation
        {
            NumberAnimation{
                target: optionsBox
                properties: "x"
                from:0
                to:main.width
                duration: animationDuration
                easing.type:Easing.InBack
            }
            NumberAnimation{
                target: mainWordBox
                properties: "x"
                from:0
                to:main.width
                duration: animationDuration
                easing.type: Easing.InBack
                easing.overshoot: 2.5
            }
        }
        ParallelAnimation{
            NumberAnimation{
                target: optionsBox
                properties: "x"
                from:-main.width
                to:0
                duration: animationDuration
                easing.type:Easing.OutBack
            }
            NumberAnimation{
                target: mainWordBox
                properties: "x"
                from:-main.width
                to:0
                duration: animationDuration
                easing.type: Easing.OutBack
                easing.overshoot: 2.5
            }
        }
    }

    states:[State{
                name:"start"
                PropertyChanges {
                    target: optionsBox
                    opacity:0
                }
                PropertyChanges {
                    target: mainWordBox
                    opacity:0
                }
                PropertyChanges{
                    target:startingBanner
                    opacity:1
                    enabled:true
                }
                PropertyChanges {
                    target: nextButton
                    opacity:0
                }
        },
           State{
               name:"test"
               PropertyChanges {
                   target: optionsBox
                   opacity:1
               }
               PropertyChanges {
                   target: mainWordBox
                   opacity:1
               }
               PropertyChanges{
                   target:startingBanner
                   opacity:0
                   enabled:false
               }
               PropertyChanges {
                   target: nextButton
                   opacity:1
               }
            }

    ]

    transitions: Transition {
        from: "start"
        to: "test"

        SequentialAnimation{
            NumberAnimation{
                target: startingBanner
                properties: "opacity"
                duration: startBannerAnimationDuration
            }
            NumberAnimation{
                targets: [mainWordBox,optionsBox]
                properties: "opacity"
                duration: startBannerAnimationDuration
            }
        }

    }
}
