import QtQuick 2.7
import QtQuick.Controls 2.2
import "./component" as ImComponent
Item {
    id:root
    visible: true;
    property string tipText: ""
    property var tables:[]
    Rectangle{
        anchors.fill:parent
        color: "black"
        ListView{
            id:mlist
            height: parent.height
            width: parent.width * 0.7
            currentIndex:0
            model: dataBase.getTablesName()
            spacing: 10
            clip:true
            property bool ischeck: false
            delegate:CheckDelegate {
                id: control
                width: mlist.width
                text:modelData
                checked: mlist.ischeck
                font.pixelSize:15
                onClicked: {
                    if(checked)
                        tables.push(modelData);
                    else
                        tables.pop(modelData);
//                    console.log("clicked:", modelData,checked,tables,tables.length)
                }

                contentItem: Text {
                    rightPadding: control.indicator.width + control.spacing
                    text: control.text
                    font: control.font
                    color: control.down ? "white" : "yellow"
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }

                indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: control.width - width - control.rightPadding
                    y: control.topPadding + control.availableHeight / 2 - height / 2
                    radius: 3
                    color: "transparent"
                    border.color: control.down ? "white" : "yellow"

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 2
                        color: control.down ? "white" : "yellow"
                        visible: control.checked
                    }
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    visible: control.down || control.highlighted
                    color:  "transparent"
                }
            }

        }

        Rectangle{
            id:button
            anchors.right: parent.right
            color:"transparent"
            height: parent.height
            width: parent.width * 0.3
            Column{
                anchors.top: parent.top
                height: parent.height * 0.5
                anchors.topMargin: height
                width: parent.width
                spacing: height * 0.1
                ImComponent.IMButton{
                    id:mdeleteall
                    context: mlist.ischeck? "Cancel":"Select All"
                    width: parent.width * 0.95
                    height: button.height * 0.13
                    onClicked: {
                        mlist.ischeck = !mlist.ischeck
//                        console.debug(mlist.model,mlist.model.length)
                        tables = [];
                        if(mlist.ischeck){
                                tables = mlist.model
                        }
//                        console.log("clicked:", tables,tables.length)
                    }
                }
                ImComponent.IMButton{
                    id:mdelete
                    context:"Delete"
                    width: parent.width * 0.95
                    height: button.height * 0.13
                    onClicked: {
                        var res = dataBase.deleteTables(tables)
                        message.my_info = res;
                        message.visible = true;
                        mlist.model = dataBase.getTablesName();
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
