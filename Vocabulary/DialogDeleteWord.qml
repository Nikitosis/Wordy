import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

MessageDialog{
    title:"Удаление слова"
    text:"Подтвердите удаление слова"

    standardButtons: StandardButton.Apply | StandardButton.Cancel

    onApply: {

    }
}
