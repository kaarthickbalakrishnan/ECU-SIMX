//Reference: https://stackoverflow.com/questions/36093417/how-to-add-dynamic-data-to-a-qml-table/36134284

import QtQuick.Window 2.2
import QtQuick.Controls 1.1
import QtQuick 2.3

Window {
    visible: true
    width:550
    height: 360
    color: "#ebeaea"
    title: qsTr("CAN RAW Sender")

    ListModel {
            id: libraryModel
            objectName: "libraryModel"
            ListElement {
                canID: "123"
                message: "11 22 33 44 55 66 77 88"
                period: "500"
                send: "Btn"
            }
            ListElement {
                canID: "222"
                message: "55 66 77"
                period: "1000"
                send: "Btn"
            }
        }

    TableView {
        x: 6
        y: 73
        width: 532
        height: 276
        backgroundVisible: false
        highlightOnFocus: true
        objectName: "canTable"
        TableViewColumn {
                role: "canID"
                title: "CAN ID"
                width: 80
                delegate: Item {
                            TextField {
                                id: canidIn
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCente
                                width: 70
                                height: 20
                                placeholderText: qsTr("CAN ID")
                            }
                        }
            }
            TableViewColumn {
                role: "message"
                title: "CAN Message"
                width: 200
                delegate: Item {
                            TextField {
                                id: messageIn
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCente
                                width: 190
                                height: 20
                                placeholderText: qsTr("CAN Message")
                            }
                        }
            }
            TableViewColumn {
                role: "loop"
                title: "Loop"
                width: 50
                delegate: Item {
                            CheckBox {
                                id: loopActive
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                x: 263
                                y: 45
                                text: qsTr("")
                                checked: false
                            }
                        }
            }
            TableViewColumn {
                role: "period"
                title: "Period"
                width: 100
                delegate: Item {
                            TextField {
                                id: periodIn
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCente
                                width: 90
                                height: 20
                                placeholderText: qsTr("period")
                            }
                        }
            }
            TableViewColumn {
                role: "send"
                title: "Send"
                width: 100
                delegate: Item {
                    Button {
                        id: send
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCente
                        width: 45
                        height: 15
                        text: qsTr("Send")
                        onClicked: canSender.getCAN_message();
                    }
                }
            }
            model: libraryModel
        }

    Button {
        id: add
        x: 6
        y: 30
        width: 64
        height: 26
        text: qsTr("Add")
        onClicked: libraryModel.append({"canID" : "", "message" : " ", "period" : " " , "send" : " "})
    }
}

