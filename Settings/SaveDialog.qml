import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Dialog {
    id: saveDialog
    property int dialogHeight
    property int dialogWidth
    property string path
    property alias fileName:fileNameField.text

    //height: dialogHeight
   // width: dialogWidth


    standardButtons: StandardButton.Apply | StandardButton.Cancel

    contentItem: Rectangle {
        width: dialogWidth
        height: dialogHeight
        color: "#f7f7f7"

        MouseArea{
            id:keyboardHider
            anchors.fill:parent

            onClicked: {
                Qt.inputMethod.hide()
                fileNameField.focus=false
            }
        }

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: fileNameField.top
            color: "#f7f7f7"

            Text {
                id: textLabel
                anchors.fill: parent
                text: "Do you want to copy WordyWorld's database to "+path+"\n\nEnter the name of the copy"
                color: "#34aadc"
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        TextField
        {
            id:fileNameField
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: dividerHorizontal.top
            height: Math.max(16,parent.height/8)

            anchors.bottomMargin: parent.height/10

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: dividerHorizontal
            color: "#d7d7d7"
            height: 2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: row.top
        }

        Row {
            id: row
            height: 100

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            Button {
                id: dialogButtonCancel

                anchors.top: parent.top
                anchors.bottom: parent.bottom

                width: parent.width / 2 - 1


                background: Rectangle {
                    color: dialogButtonCancel.pressed ? "#d7d7d7" : "#f7f7f7"
                    border.width: 0

                    Text {
                        text: qsTr("Cancel")
                        color: "#34aadc"
                        anchors.fill: parent

                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                onClicked: {saveDialog.click(StandardButton.Cancel) }
            }

            Rectangle {
                id: dividerVertical
                width: 2

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "#d7d7d7"
            }

            Button {
                id: dialogButtonOk

                anchors.top: parent.top
                anchors.bottom: parent.bottom

                width: parent.width / 2 - 1


                background: Rectangle {
                    color: dialogButtonOk.pressed ? "#d7d7d7" : "#f7f7f7"
                    border.width: 0
                }

                Text {
                    text: qsTr("Ok")
                    color: "#34aadc"
                    anchors.fill: parent

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                onClicked: {
                    saveDialog.click(StandardButton.Apply)
                    saveDialog.close()
                }
            }
        }
    }
}
