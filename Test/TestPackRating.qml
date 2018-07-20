import QtQuick 2.0

Item {
    property int rating: 1
    property int imgSize: Math.min(height*1.2,width/6)

    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: firstRate
            source: rating>=1 ? "qrc:/img/EducActive.png" : "qrc:/img/EducPassive.png"
            height: imgSize
            width: imgSize
            fillMode: Image.PreserveAspectFit

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    rating=1
                }
            }
        }

        Image {
            id: secondRate
            source: rating>=2 ? "qrc:/img/EducActive.png" : "qrc:/img/EducPassive.png"
            height: imgSize
            width: imgSize
            fillMode: Image.PreserveAspectFit

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    rating=2
                }
            }
        }

        Image {
            id: thirdRate
            source: rating>=3 ? "qrc:/img/EducActive.png" : "qrc:/img/EducPassive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    rating=3
                }
            }
        }

        Image {
            id: fourthRate
            source: rating>=4 ? "qrc:/img/EducActive.png" : "qrc:/img/EducPassive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    rating=4
                }
            }
        }

        Image {
            id: fifthRate
            source: rating>=5 ? "qrc:/img/EducActive.png" : "qrc:/img/EducPassive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    rating=5
                }
            }
        }

        Image {
            id: sixthRate
            source: rating>=6 ? "qrc:/img/EducActive.png" : "qrc:/img/EducPassive.png"
            height: imgSize
            width: imgSize

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    rating=6
                }
            }
        }



    }
}
