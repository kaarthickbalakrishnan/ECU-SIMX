import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import QtGraphicalEffects.private 1.0
import QtQuick.Controls.Styles.Desktop 1.0
import QtQuick.Extras 1.2
import QtQuick.Layouts 1.3



    ApplicationWindow {
            id:mainWindow

            visible: true

            width: 840

            height: 480
            color: "#ffffff"
            title: "ECU SimX"
            ToolBar {

                ToolButton {
                    id: btn_canSenderTab
                    x: 161
                    y: -1
                    width: 160
                    height: 45
                    text: "Can Sender"
                    checkable: true
                    onClicked: {
                        btn_canSenderTab.checked= true
                        btn_canViewerTab.checked=false
                        btn_busConfTab.checked=false
                        
                        w_busConfTab.visible=false
                        w_canViewerTab.visible=false
                        w_canSenderTab.visible=true

                    }


                }

                    ToolButton {
                        id: btn_canViewerTab
                        x: 322
                        y: -1
                        width: 160
                        height: 45
                        text: "Can Viewer"
                        checkable: true
                        onClicked: {
                        	btn_canSenderTab.checked=false
                        	btn_canViewerTab.checked=true
                        	btn_busConfTab.checked=false
                        
                            w_canSenderTab.visible=false
                            w_busConfTab.visible=false
                            w_canViewerTab.visible=true
                        }
                    }
                    ToolButton {
                        id: btn_busConfTab
                        x: 0
                        y: 0
                        width: 160
                        height: 45
                        text: "Bus Configuration"
                        checkable: true
                        activeFocusOnPress: true
                        opacity: 0.7
                        onClicked: {
							btn_canSenderTab.checked=false
                        	btn_canViewerTab.checked=false
                        	btn_busConfTab.checked=true
                        	
                            w_canViewerTab.visible=false
                            w_canSenderTab.visible=false
                            w_busConfTab.visible=true
                        }
                    }

                }



            //Button {

              //  text: "Open modal window"

                //anchors.centerIn: parent

                //onClicked: { modalWindow.show() }

            //}



            Item {
                id: w_busConfTab
                x: 63
                y: 64
                //flags: Qt.Popup
                width: 370
                height: 320
                visible: false
                //color: "#c5cad1"
                //title: qsTr("BUS CONFIGURATION")


                Button {
                    id: send_button
                    x: 139
                    y: 260
                    text: qsTr("CONFIGURE")
                    onClicked: testWindow.getBUS_configuration();
                }


                Text {
                    id: channel
                    x: 21
                    y: 116
                    width: 112
                    height: 36
                    text: qsTr("CHANNEL")
                    font.weight: Font.DemiBold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                }

                Text {
                    id: bit_rate
                    x: 21
                    y: 186
                    width: 112
                    height: 36
                    text: qsTr("BIT RATE")
                    font.weight: Font.DemiBold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                }


                Text {
                    id: bus_type
                    x: 21
                    y: 47
                    width: 112
                    height: 36
                    color: "#050303"
                    text: "BUS TYPE"
                    font.weight: Font.DemiBold
                    styleColor: "#000000"
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.NativeRendering
                    textFormat: Text.RichText
                    fontSizeMode: Text.FixedSize
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                }


                TextField {
                    objectName: "bitrate_in"
                    id: bitrate_Input
                    x: 172
                    y: 186
                    width: 125
                    height: 36
                    text: "250000"
                    placeholderText: qsTr("bitrate")
                }

                ComboBox {
                    objectName: "bustype_in"
                    id: bustype1
                    x: 172
                    y: 47
                    width: 125
                    height: 36
                    model: ["socketcan","virtual"]
                    onCurrentIndexChanged:
                    {
                        if(currentIndex === 0)
                            channel1.model=["vcan0","vcan1"]
                        else if (currentIndex === 1)
                            channel1.model =["can0","can1"]
                    }
                }


                ComboBox {
                    objectName: "channel_in"
                    id: channel1
                    x: 172
                    y: 116
                    width: 125
                    height: 36
                }

                    Button {
                        id: buttonn
                        x: 247
                        y: 260
                        text: qsTr("SEND TEST")
                        onClicked: testWindow.send_can();
                    }
            }



            Item {
                id:w_canSenderTab
                //flags: Qt.Popup
                width:640
                height: 420
                visible: false
                //color: "#fafafa"
                //title: qsTr("Can Raw Message Sender")

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
                        x: 16
                        y: 111
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
                                            testWindow.send()
                                             }
                                    }
                                }
                        }
                        model: canDataModel
                    }

                Button {
                    id: add
                    x: 12
                    y: 60
                    width: 64
                    height: 30
                    text: qsTr("Add Row")
                    visible: true
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

            Item {
                id: w_canViewerTab
                x: 0
                y: 52
                objectName: "viewWindow"
                visible:false
                width: 640
                height: 412

                TextArea {
                    objectName: "viewPanelText"
                    id: viewPanel
                    readOnly: true
                    x: 28
                    y: 57
                    width: 780
                    height: 293
                    text: qsTr("")
                    font.family: "Times New Roman"
                    font.pixelSize: 12


                }

                Connections
                {
                    target: testWindow
                    onSig_canViewChanged: {
                        viewPanel.append(qsTr(testWindow.updateView))
                    }
                }

                Button {
                    id: button
                    x: 62
                    y: 379
                    width: 537
                    height: 25
                    text: qsTr("Play / Pause")
                    //checked: false
                    checkable: true
                    onClicked: viewPanel.append("Button Pressed")
                }

                Label {
                    id: label
                    x: 28
                    y: 8
                    width: 513
                    height: 43
                    text: qsTr("Count	Time	Diff.Time	CAN ID	DLC	CAN Message
            ")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }




    }
