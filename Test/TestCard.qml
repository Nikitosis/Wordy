import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    function initCard()
    {
        firstOption.text=testInfo.getOptions()
    }

    GroupBox{

        Column{
            Row{
                CheckBox{
                    id:firstOption
                }
                CheckBox{
                    id:secondOption
                }
            }
            Row{
                CheckBox{
                    id:thirdOption
                }
                CheckBox{
                    id:fouthOption
                }
            }
        }
    }

}
