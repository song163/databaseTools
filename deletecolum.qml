import QtQuick 2.7
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.2
import Qt.labs.platform 1.0
import "./component" as ImComponent
Item {
    id:root
    visible: true;
    property string tablename
    property string columname
    Rectangle{
        //        anchors.fill:parent
        width: parent.width
        height: parent.height
        color: "#0e0e0e"
        Column{
            anchors.centerIn: parent
            width: parent.width * 0.95
            height: parent.height * 0.6
            spacing: 10
            Row{
                width: parent.width
                height: parent.height / 8
                spacing: 5
                Label{
                    width: parent.width / 4
                    height: parent.height
                    text: "Table Name:"
                    color:"#e0e0e0"
                    font.pixelSize:  height * 0.5
                }

                ImComponent.IMComBoxCustom{
                    id: textField
                    width: parent.width * 0.73
                    height: parent.height
                    initIndex : 0
                    model: dataBase.getTablesName()
                    listTextColor: "#21be2b"
                    showTextColor: "#e0e0e0"
                    onActivated: {
                        root.tablename = textField.textAt(index);
                        mcolumn.model = dataBase.getColumnName(root.tablename)
                    }
                    Component.onCompleted: {
                        root.tablename = textField.textAt(initIndex);
                        mcolumn.model = dataBase.getColumnName(root.tablename)
                    }
                }
            }
            Row{
                width: parent.width
                height: parent.height / 8
                spacing: 5
                Label{
                    width: parent.width / 4
                    height: parent.height
                    text: "Column Name:"
                    color:"#e0e0e0"
                    font.pixelSize:  height * 0.5
                }
                ImComponent.IMComBoxCustom{
                    id: mcolumn
                    width: parent.width * 0.73
                    height: parent.height
                    initIndex : 0
                    listTextColor: "#21be2b"
                    showTextColor: "#e0e0e0"
                    onActivated: {
                        root.columname = mcolumn.textAt(index);
                        console.debug("current index ",index, root.columname,currentIndex)
                        mcolumn.model = dataBase.getColumnName(root.tablename)

                    }
                    Component.onCompleted: {
                        root.columname = mcolumn.textAt(initIndex);
                    }
                }
            }

            Row{
                width: parent.width
                height: parent.height / 8
                spacing: 10
                Item{
                    width: parent.width *2 / 3
                    height: parent.height
                }
                ImComponent.IMButton{
                    id:out
                    width: parent.width *0.3
                    height:  parent.height
                    context: "Delete"
                    onClicked: {
                        console.debug("tablename",root.tablename,"columname",root.columname)

                        var res= dataBase.deleteColumn(root.tablename,root.columname)
                        message.my_info = res;
                        message.visible = true;
                        mcolumn.model = dataBase.getColumnName(root.tablename)


                    }
                }


            }

        }
        ImComponent.IMMessageDialog {
            id:message
            width: root.width * 0.7
            height: root.height / 3
            backgroundColor:"#0e0e0e"
            title: "message"
            button_text: "Close"
        }
    }

}
