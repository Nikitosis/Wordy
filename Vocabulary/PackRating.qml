import QtQuick 2.0

Item {
    property int rating: rating
    property int imgSize: Math.min(height,width/5)



    function updateRating(newRating)
    {
        if(newRating>=1)
            firstRate.source= "qrc:/img/FireActive.png"
        else
            firstRate.source= "qrc:/img/FirePassive.png"

        if(newRating>=2)
            secondRate.source= "qrc:/img/FireActive.png"
        else
            secondRate.source= "qrc:/img/FirePassive.png"

        if(newRating>=3)
            thirdRate.source= "qrc:/img/FireActive.png"
        else
            thirdRate.source= "qrc:/img/FirePassive.png"

        if(newRating>=4)
            fourthRate.source= "qrc:/img/FireActive.png"
        else
            fourthRate.source= "qrc:/img/FirePassive.png"

        if(newRating>=5)
            fifthRate.source= "qrc:/img/FireActive.png"
        else
            fifthRate.source= "qrc:/img/FirePassive.png"
        rating=newRating
    }


    Row{
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: firstRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize
        }

        Image {
            id: secondRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize
        }

        Image {
            id: thirdRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize
        }

        Image {
            id: fourthRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize
        }

        Image {
            id: fifthRate
            source: "qrc:/img/FireActive.png"
            height: imgSize
            width: imgSize
        }



    }

}
