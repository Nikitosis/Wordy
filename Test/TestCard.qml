import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    id:main
    property string rightColor:"green"
    property string falseColor:"orange"
    property string defaultColor: "grey"
    property int    animationDuration: 500
    function changeCard()
    {
        changeCardAnimation.start()
        //nextButton.enabled=false
    }

    function initCard()
    {
        testInfo.newTest()
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
        id:mainWordBox
        anchors.top: parent.top
        height: parent.height/4
        width: parent.width


        Text{
            id:mainWordText
            anchors.centerIn: parent
            fontSizeMode: Text.Fit
        }
    }

    Item{
        id:optionsBox

        anchors.top: mainWordBox.bottom

        height: parent.height/2
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
                anchors.centerIn: parent
                text:firstOption.text
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    firstOption.color=firstOption.isRight? rightColor : falseColor
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
                anchors.centerIn: parent
                text:secondOption.text
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    secondOption.color=secondOption.isRight? rightColor : falseColor
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
                anchors.centerIn: parent
                text:thirdOption.text
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    thirdOption.color=thirdOption.isRight? rightColor : falseColor
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
                anchors.centerIn: parent
                text:fourthOption.text
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    fourthOption.color=fourthOption.isRight? rightColor : falseColor
                    optionClicked()
                }
            }

        }

    }

    Button{
        id:nextButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: optionsBox.bottom
        width: parent.width/3
        onClicked: {
            changeCard()
        }
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
}
