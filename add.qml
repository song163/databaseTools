import QtQuick 2.7
import "./component" as ImComponent
Item {
    visible: true;
    Rectangle{
        anchors.fill:parent
        color: "yellow"

        ImComponent.IMButton{
            id:mdelete
            context:"test"
            width: 150
            height: 60
            onClicked: {
                 dataBase.testInsert();
//                var res = dataBase.deleteTables(tables)
            }
        }


    }

}
