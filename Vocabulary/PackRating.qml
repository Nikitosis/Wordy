import QtQuick 2.0

Item {
    property int rating: rating
    property int imgSize: Math.min(height,width/5)


    signal changePack(int newRating)
    signal hoverRating(int hoverIndex)

    function updateImages(curRating)
    {
        if(curRating>=1)
            firstRate.source= "qrc:/img/FireActive.png"
        else
            firstRate.source= "qrc:/img/FirePassive.png"

        if(curRating>=2)
            secondRate.source= "qrc:/img/FireActive.png"
        else
            secondRate.source= "qrc:/img/FirePassive.png"

        if(curRating>=3)
            thirdRate.source= "qrc:/img/FireActive.png"
        else
            thirdRate.source= "qrc:/img/FirePassive.png"

        if(curRating>=4)
            fourthRate.source= "qrc:/img/FireActive.png"
        else
            fourthRate.source= "qrc:/img/FirePassive.png"

        if(curRating>=5)
            fifthRate.source= "qrc:/img/FireActive.png"
        else
            fifthRate.source= "qrc:/img/FirePassive.png"
    }

    function updateRating(newRating)
    {
        updateImages(newRating)
        rating=newRating
    }

    onHoverRating: {
        updateImages(rating)
        if((hoverIndex>=2 && rating<2) || (hoverIndex<2 && rating>=2))
        {
            secondRate.source="qrc:/img/FirePossible.png"
        }

        if((hoverIndex>=3 && rating<3) || (hoverIndex<3 && rating>=3))
        {
            thirdRate.source="qrc:/img/FirePossible.png"
        }
        if((hoverIndex>=4 && rating<4) || (hoverIndex<4 && rating>=4))
        {
            fourthRate.source="qrc:/img/FirePossible.png"
        }
        if((hoverIndex>=5 && rating<5) || (hoverIndex<5 && rating>=5))
        {
            fifthRate.source="qrc:/img/FirePossible.png"
        }
        console.log("hoverRating")
    }




    Row{
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: firstRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hoverRating(1)
                onClicked: {
                    changePack(1)
                    updateRating(1)
                }
            }
        }

        Image {
            id: secondRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hoverRating(2)
                onClicked: {
                    console.log("kk")
                    changePack(2)
                    updateRating(2)
                }
            }
        }

        Image {
            id: thirdRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hoverRating(3)
                onClicked: {
                    changePack(3)
                    updateRating(3)
                }
            }
        }

        Image {
            id: fourthRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hoverRating(4)
                onClicked: {
                    changePack(4)
                    updateRating(4)
                }
            }
        }

        Image {
            id: fifthRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hoverRating(5)
                onClicked: {
                    changePack(5)
                    updateRating(5)
                }
            }
        }



    }

}
