import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "./component" as ImComponent
ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("DatazBase Tools V0.1")
    Rectangle{
        anchors.fill: parent
        color: "black"
        Label{
            id:tital
            text: qsTr("DataBase Tool V0.1")
            color: "yellow"
            font.bold: true
            width: parent.width
            height: parent.height * 0.12
            font.pixelSize: height * 0.8
            font.family: "Courier"
            font.italic: true
            horizontalAlignment:Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            Label{
                id:statetip
                text:dataBase.isDBOpen()? "database open finished!":"database open error!"
                color: dataBase.isDBOpen()?"yellow":"red"
                width: parent.width /2
                height: parent.height * 0.3
                font.pixelSize: height * 0.6
                font.family: "Courier"
                font.italic: true

            }
        }
        Row{
            width: parent.width
            height: parent.height * 0.9
            anchors.top: tital.bottom
            spacing: 1
            Rectangle{
                id:buttonArea
                width: parent.width *0.2
                height: parent.height
                color: "transparent"
                border.width : 2
                border.color : "yellow"
                radius: 10
                ListView {
                    id:mlist
                    anchors.left: buttonArea.left
                    anchors.leftMargin: buttonArea.width * 0.05
                    width: buttonArea.width * 0.9
                    height: buttonArea.height
                    currentIndex:0
                    model: ["Creat and Init","Add Colum","Delete Colum","Delete Table","Delete Context","Import Context","Export Context","TestButton"]
                    spacing: 1
                    clip:true
                    onCurrentIndexChanged: {
                        console.debug("index",currentIndex);
                        if(currentIndex == 0 )
                            pageLoader.source = "init.qml"
                        else if(currentIndex == 1)
                            pageLoader.source = "addcolum.qml"
                        else if(currentIndex == 2)
                            pageLoader.source = "deletecolum.qml"
                        else if(currentIndex == 3)
                            pageLoader.source = "delete.qml"
                        else if(currentIndex == 4)
                            pageLoader.source = "deletecontext.qml"
                        else if(currentIndex == 5)
                            pageLoader.source = "importcontext.qml"
                        else if(currentIndex == 6)
                            pageLoader.source = "exportcontext.qml"
                        else if(currentIndex == 7)
                            pageLoader.source = "add.qml"
                    }

                    delegate: RadioDelegate {
                        id: control0
                        text: modelData
                        checked: index == 0
                        onCheckedChanged: {
                            mlist.currentIndex = index
                        }
                        contentItem: Text {
                            height: control0.indicator.height
                            width: control0.indicator.width
                            text: control0.text
                            y:control0.indicator.y
                            font.pixelSize: 15
                            font.bold: true
//                            font: control0.font
                            wrapMode: Text.Wrap
                            opacity: enabled ? 1.0 : 0.3
                            color: "#e0e0e0"
//                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        indicator: Rectangle {
                            implicitWidth: mlist.width
                            implicitHeight:mlist.height /8

                            y: mlist.height / 8 - height * 0.8
                            radius: 7
                            color: "transparent"
                            border.color: control0.down ? "#17a81a" : "#21be2b"

                            Rectangle {
                                width: parent.width
                                height: parent.height
                                anchors.centerIn: parent
                                radius: 7
                                color: control0.down ? "#17a81a" : "#21be2b"
                                visible: control0.checked
                            }
                        }

                        background: Rectangle {
                            y:control0.indicator.y
                            width: control0.indicator.width
                            height: control0.indicator.height
                            visible: control0.down || control0.highlighted
                            color: control0.down ? "#bdbebf" : "#eeeeee"

                        }
                    }
                    ScrollBar.vertical: ScrollBar {
                                        id: scrollBar_v
                                        policy: ScrollBar.AsNeeded
                                    }
                }

            }
            Rectangle{
                id:show
                color: "transparent"
                border.width :2
                border.color : "yellow"
                width: parent.width *0.8
                height: parent.height
                radius: 10
                Loader {
                    anchors.fill: parent
                    id: pageLoader
                    Component.onCompleted: {
                    pageLoader.source = "init.qml"}
                }

            }
         }

    }

}
