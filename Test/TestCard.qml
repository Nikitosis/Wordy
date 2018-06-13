import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
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




        console.log("init card")
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
        anchors.leftMargin: parent.width/8
        anchors.rightMargin: parent.width/8

        CheckBox{
            id:firstOption
            height: parent.height/3
            width: parent.width/3
            anchors.left: parent.left
            anchors.top: parent.top
            property bool isRight: false

            LayoutMirroring.enabled: true                                                         //to have text from left of checkbox
            LayoutMirroring.childrenInherit: true

            style: CheckBoxStyle {
                   indicator: Rectangle {

                           implicitWidth: Math.min(firstOption.width/3,firstOption.height/3)
                           implicitHeight: Math.min(firstOption.width/3,firstOption.height/3)
                           radius: 3
                           border.width: 1
                           Rectangle {
                               visible: control.checked
                               color: firstOption.isRight ? "green" : "orange"
                               border.color: "#333"
                               radius: 1
                               anchors.margins: 4
                               anchors.fill: parent
                           }
                   }
               }

        }
        CheckBox{
            id:secondOption
            height: parent.height/3
            width: parent.width/3
            anchors.left: parent.left
            anchors.top: parent.top

            property bool isRight: false


            style: CheckBoxStyle {
                   indicator: Rectangle {

                           implicitWidth: Math.min(secondOption.width/3,secondOption.height/3)
                           implicitHeight: Math.min(secondOption.width/3,secondOption.height/3)
                           radius: 3
                           border.width: 1
                           Rectangle {
                               visible: control.checked
                               color: secondOption.isRight? "green" : "orange"
                               border.color: "#333"
                               radius: 1
                               anchors.margins: 4
                               anchors.fill: parent
                           }
                   }
               }

        }
        CheckBox{
            id:thirdOption
            height: parent.height/3
            width: parent.width/3
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            property bool isRight: false

            LayoutMirroring.enabled: true                                                         //to have text from left of checkbox
            LayoutMirroring.childrenInherit: true

            style: CheckBoxStyle {
                   indicator: Rectangle {

                           implicitWidth: Math.min(thirdOption.width/3,thirdOption.height/3)
                           implicitHeight: Math.min(thirdOption.width/3,thirdOption.height/3)
                           radius: 3
                           border.width: 1
                           Rectangle {
                               visible: control.checked
                               color: thirdOption.isRight ? "green" : "orange"
                               border.color: "#333"
                               radius: 1
                               anchors.margins: 4
                               anchors.fill: parent
                           }
                   }
               }

        }
        CheckBox{
            id:fourthOption
            height: parent.height/3
            width: parent.width/3
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            property bool isRight: false


            style: CheckBoxStyle {
                   indicator: Rectangle {

                           implicitWidth: Math.min(fourthOption.width/3,fourthOption.height/3)
                           implicitHeight: Math.min(fourthOption.width/3,fourthOption.height/3)
                           radius: 3
                           border.width: 1
                           Rectangle {
                               visible: control.checked
                               color: fourthOption.isRight? "green" : "orange"
                               border.color: "#333"
                               radius: 1
                               anchors.margins: 4
                               anchors.fill: parent
                           }
                   }
               }

        }


    }

    Button{
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width/3
        height: 50
        onClicked: {
            initCard()
        }
    }
}
