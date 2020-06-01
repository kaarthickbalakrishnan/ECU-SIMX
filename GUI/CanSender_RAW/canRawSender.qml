//Reference: https://stackoverflow.com/questions/36093417/how-to-add-dynamic-data-to-a-qml-table/36134284
//https://code.woboq.org/qt5/qtquickcontrols/src/controls/doc/src/qtquickcontrols-tableview.qdoc.html
//https://doc.qt.io/qt-5/qtexamplesandtutorials.html


import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Window {
    visible: true
    width:640
    height: 420
    color: "#fafafa"
    title: qsTr("Can Raw Message Sender")

    ListModel {
            id: canDataModel
            objectName: "canDataModel"
                ListElement {
                    objectName: "can"
                    canID: ""
                    message:""
                    loop:false
                    period: ""
                    type:"Standard"
                    send: "Btn"
                }
              }

        TableView {
            id: tableViewCanData
            x: 24
            y: 77
            width: 592
            height: 292
            opacity: 1
            backgroundVisible: false
            highlightOnFocus: true
            objectName: "canTable"
            TableViewColumn {
                        role: "canID"
                        title: "CAN Id"
                        width: 70
                        delegate:Item{
                                 TextField {
                                    id: canidIn
                                    width: 70
                                    height: parent.height
                                    opacity: 1
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCente
                                    placeholderText: qsTr("Identifier")
                                    //setting validator to get only hexa-decimal values
                                    validator:RegExpValidator{
                                        regExp: /[0-9a-fA-F]{1,4}/
                                           }
                                    //to store new text when entered
                                    onTextChanged: {
                                        acceptableInput ? print("Input acceptable") : print("Input not acceptable")
                                        model.canID=text
                                          }
                                  }
                        }
            }
            TableViewColumn {
                role: "message"
                title: "CAN Data"
                width: 220
                delegate:Item{
                        TextField {
                        id: messageIn
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCente
                        width: parent.width
                        height: parent.height
                        placeholderText: qsTr("Data")
                        //setting validator to get only hexa-decimal values
                        validator:RegExpValidator{
                            regExp: /[0-9a-fA-F]{1,16}/
                                 }
                        //to store new text when entered
                        onTextChanged:{
                            model.message=text
                            acceptableInput ? print("Input acceptable") : print("Input not acceptable")
                                 }

                    }
                }
            }
            TableViewColumn {
                id: tableViewColumn1
                role: "loop"
                title: "Periodic"
                width: 70
                delegate:Item{
                    CheckBox {
                        id: loopActive
                        text: "Enable"
                        transformOrigin: Item.Center
                        anchors.top: parent.top
                        height: parent.height
                        anchors.topMargin: 0
                        anchors.fill: parent
                        anchors.centerIn: parent
                        checked: false
                        //finding whether the message is periodic or not
                        onCheckedChanged: model.loop=checked
                    }
                }
            }
            TableViewColumn {
                role: "period"
                title: "Time"
                width: 70
                delegate:Item{
                    TextField {
                                id: periodIn
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCente
                                width: parent.width
                                height: parent.height
                                maximumLength: 5
                                placeholderText: qsTr("ms")
                                //setting validator to get only integer values from 0-10000
                                validator: IntValidator{
                                    top: 10000
                                    bottom: 0

                                     }
                                //to store new text when entered
                                onTextChanged: {
                                    acceptableInput ? print("Input acceptable") : print("Input not acceptable")
                                    model.period=text
                                    }
                                }
                             }
            }
            TableViewColumn{
                id: tableViewColumn
                role:"type"
                title: "CAN Type"
                width:90
                delegate: Item{
                    ComboBox{
                        id: stdEx
                        height: parent.height
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.fill: parent
                        transformOrigin: Item.Center
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        model: ["Standard","Extended"]
                        //Checking the type of can message
                        onCurrentTextChanged: model.type=currentText
                    }
                }
            }

            TableViewColumn {
                role: "send"
                title: "Send"
                width: 70
                delegate:Item{
                    Button {
                            id: send
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            text: qsTr("Send")
                            //text stored textFields when send button is clicked
                            onClicked: {
                                testid.text = canDataModel.get(tableViewCanData.currentRow).canID
                                testmsg.text = canDataModel.get(tableViewCanData.currentRow).message
                                testperiod.text = canDataModel.get(tableViewCanData.currentRow).loop
                                testtime.text = canDataModel.get(tableViewCanData.currentRow).period
                                //testtype.text=canDataModel.get(tableViewCanData.currentRow).type
                                testWindow.testing()
                                 }
                        }
                    }
            }
            model: canDataModel
        }

    Button {
        id: add
        x: 6
        y: 30
        width: 64
        height: 30
        text: qsTr("Add Row")
        //creating new ListModel row
        onClicked: {
            canDataModel.append({"canID" : "", "message" : " ", "period" : " "})
          }
    }

    TextField {
        id: testid
        objectName: "test_id"
        x: 12
        y: 375
        width: 84
        height: 23
        visible: false
        placeholderText: qsTr("Current id")
    }
    TextField {
        id: testmsg
        objectName: "test_msg"
        x: 102
        y: 375
        width: 156
        height: 23
        visible: false
        placeholderText: qsTr("Current data")
    }

    TextField {
        id: testperiod
        objectName: "test_period"
        x: 272
        y: 375
        width: 80
        height: 23
        visible: false
        placeholderText: qsTr("Periodic")
    }

    TextField {
        id: testtime
        objectName: "test_time"
        x: 367
        y: 375
        width: 110
        height: 23
        visible: false
        placeholderText: qsTr("Time")
    }

    TextField {
        id: testtype
        objectName: "test_type"
        x: 519
        y: 375
        width: 85
        height: 23
        visible: false
        placeholderText: qsTr("Can type")
    }
}
