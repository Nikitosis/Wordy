import QtQuick 2.0

Item {
    property int rating: -1
    property int imgSize: Math.min(height,width/5)


    signal changePack(int newRating)

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
                onClicked: {
                    changePack(5)
                    updateRating(5)
                }
            }
        }



    }

}
