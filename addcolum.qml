import QtQuick 2.7
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.2
import Qt.labs.platform 1.0
import "./component" as ImComponent
Item {
    id:root
    visible: true;
    property string tablename
    property string datatype
    property string len
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
                    }
                    Component.onCompleted: {
                    root.tablename = textField.textAt(initIndex);
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
                TextField{
                    id:columnname
                    width: parent.width * 0.73
                    height: parent.height
                    color:"#e0e0e0"
                    placeholderText: qsTr("column_n")
                    font.pixelSize:  height * 0.5
                    background: Rectangle{
                        radius: 5
                        border.width: 1
                        border.color: "#e0e0e0"
                        color: "#0e0e0e"
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
                    text: "Data Type:"
                    color:"#e0e0e0"
                    font.pixelSize:  height * 0.5
                }

                ImComponent.IMComBoxCustom{
                    id: type
                    width: parent.width * 0.73
                    height: parent.height
                    initIndex : 0
                    model: ['serial','bigserial','bigint','int','smallint','double precision','varchar','date','timestamp without time zone']
                    listTextColor: "#21be2b"
                    showTextColor: "#e0e0e0"
                    onActivated: {
                        root.datatype = type.textAt(index);
                        console.debug("current index ",index, root.datatype,currentIndex)
                        len.text = '';
                        if(root.datatype == 'varchar')
                            mlen.visible = true;
                        else
                            mlen.visible = false;
                    }
                    Component.onCompleted: {
                        root.datatype = type.textAt(initIndex);
                    }
                }
            }
            Row{
                id:mlen
                width: parent.width
                height: parent.height / 8
                spacing: 5
                visible: false
                Label{
                    width: parent.width / 4
                    height: parent.height
                    text: "Length:"
                    color:"#e0e0e0"
                    font.pixelSize:  height * 0.5
                }
                TextField{
                    id:len
                    width: parent.width * 0.73
                    height: parent.height
                    color:"#e0e0e0"
                    font.pixelSize:  height * 0.5
                    background: Rectangle{
                        radius: 5
                        border.width: 1
                        border.color: "#e0e0e0"
                        color: "#0e0e0e"
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
                    context: "Add"
                    onClicked: {
                        var datatype;
                        console.debug("tablename",root.tablename,"datatype",root.datatype,"columnname",columnname.text,"len",len.text)
                        if(columnname.text == '')
                        {
                            message.my_info = 'Column name cannot be empty!';
                            message.visible = true;
                        }
                        else{
                            if(root.datatype == 'varchar')
                            {
                                if(len.text == ''){
                                    message.my_info = 'Column name cannot be empty!';
                                    message.visible = true;
                                }
                                else
                                    datatype = root.datatype + "("+ len.text + ")";
                            }
                            else
                                datatype = root.datatype;

                            console.debug("tablename",root.tablename,"datatype",datatype,"columnname",columnname.text)
                            var res= dataBase.addColumn(root.tablename,columnname.text,datatype)
                            message.my_info = res;
                            message.visible = true;
                        }

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
