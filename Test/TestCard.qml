import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    property string rightColor:"green"
    property string falseColor:"orange"
    property string defaultColor: "grey"
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
        anchors.bottom: optionsBox.top
        anchors.left: parent.left
        anchors.right: parent.right

        Text{
            id:mainWordText
            anchors.centerIn: parent
            fontSizeMode: Text.Fit
        }
    }

    Item{
        id:optionsBox
        anchors.fill: parent

        anchors.topMargin: parent.height/4
        anchors.bottomMargin: parent.height/4

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
            initCard()
        }
    }
}
