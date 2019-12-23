import QtQuick 2.7
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.2
import Qt.labs.platform 1.0

import "./component" as ImComponent
Item {
    id:root
    visible: true;
    property string tablename
    property string path
    Rectangle{
//        anchors.fill:parent
        width: parent.width
        height: parent.height
        color: "#0e0e0e"
        Column{
            anchors.centerIn: parent
            width: parent.width * 0.95
            height: parent.height * 0.9
            spacing: 10
            Rectangle{
                width: parent.width
                height: parent.height / 3
                radius: 5
                border.width: 1
                border.color: "gray"
                color: 'transparent'
                Label{
                    anchors.fill: parent
                    text: "
 注意：1、导入的表格必须再数据库中存在；

 2、导入的表格中不可以有自增行序列；

 3、导入的文件必须为.cvs格式；

 4、导入文件中的列必须包含表中出自增序列外的所以列；"
                    color: 'red'
                    font.pixelSize:  15

                }

            }
            Column{
                width: parent.width
                height: parent.height * 2/3
                spacing: 10
            Row{
                width: parent.width
                height: parent.height / 8
                spacing: 5
                Label{
                    width: parent.width / 10
                    height: parent.height
                    text: "Path:"
                    color:"#e0e0e0"
                    font.pixelSize:  height * 0.5
                }

                TextField{
                    id:path
                    width: parent.width * 0.73
                    height: parent.height
                    color:"#e0e0e0"
                    placeholderText: qsTr("E:/database/test1.csv")
                    font.pixelSize:  height * 0.5
                    background: Rectangle{
                        radius: 5
                        border.width: 1
                        border.color: "#e0e0e0"
                        color: "#0e0e0e"
                    }
                }
                 ImComponent.IMButton{
                    width: parent.width / 7
                    height: parent.height
                    context: "open"
                    fontsize: 10
                    onClicked: fd.open()
                    FileDialog{
                        id:fd
                        onCurrentFileChanged:
                        {
                            var m = fd.currentFile.toString() ;
                            path.text = m.slice(8)
                            root.path = path.text
                            console.debug(m,path.text)
                        }
                    }
                }

            }

//            Row{
//                width: parent.width
//                height: parent.height / 8
//                spacing: 5
//                Label{
//                    width: parent.width / 4
//                    height: parent.height
//                    text: "File Name:"
//                    color:"#e0e0e0"
//                    font.pixelSize:  height * 0.5
//                }
//                TextField{
//                    id:filename
//                    width: parent.width * 0.73
//                    height: parent.height
//                    color:"#e0e0e0"
//                    placeholderText: qsTr("tabelname")
//                    font.pixelSize:  height * 0.5
//                    background: Rectangle{
//                        radius: 5
//                        border.width: 1
//                        border.color: "#e0e0e0"
//                        color: "#0e0e0e"
//                    }
//                }
//            }
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
                        }
                        Component.onCompleted: {
                        root.tablename = textField.textAt(initIndex);
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
                    context: "Import"
                    onClicked: {
                        console.debug("path",root.path,"tablename",root.tablename)
                        var res = dataBase.importFile(root.path,root.tablename)
                        message.my_info = res;
                        message.visible = true;
                    }
                }


            }

            }
            }

            ImComponent.IMMessageDialog {
                id:message
//                visible: false
                width: root.width * 0.7
                height: root.height / 3
                backgroundColor:"#0e0e0e"
                title: "message"
                button_text: "Close"
            }

    }


}
