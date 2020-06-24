import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import QtGraphicalEffects.private 1.0
import QtQuick.Controls.Styles.Desktop 1.0
import QtQuick.Extras 1.2
import QtQuick.Layouts 1.3
import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Window 2.0




ApplicationWindow {
    id:mainWindow

    visible: true

    width: 665

    height: 454
    color: "#ffffff"
    title: "ECU SimX"
    Image { x: 0; y: 0; width: 640; height: 369; anchors.rightMargin: -1; anchors.bottomMargin: 0; anchors.leftMargin: 1; anchors.topMargin: 0; source: "mainwindow.jpeg"; fillMode: Image.Tile; anchors.fill: parent;  opacity: 0.9
    }

    menuBar: MenuBar {

        Menu {
            title: "File"
            MenuItem {
                text: "Open"
                onTriggered: myWindow.open();
            }
            MenuItem {
                text: "Quit"
                onTriggered: mainWindow.close();
            }

            Window{
                id: myWindow
                title: "Window"
                width: 300
                height: 300
                visible: false
                function open(){
                    visible = true
                }
                function close(){
                    visible = false
                }
            }
        }

        Menu {
            title: "Help"
            MenuItem { text: "Help Contents"
                onTriggered:Qt.openUrlExternally("/helpDoc.pdf")//url of filesource to be mentioned
            }
            MenuItem {
                text: "About"
                onTriggered: aboutWin.open();
            }
            Window{
                id: aboutWin
                title: "About"
                width: 300
                height: 300
                visible: false
                Text{
                   objectName: "aboutText"
                   width: parent.width
                   id: about_Text
                   x: 0
                   y: 0
                   height: parent.height
                   wrapMode: "WordWrap"
                    text: " ANCIT is a growing Automotive Tooling and Engineering Services Company based out of US, Germany and Bangalore - INDIA catering prominent enterprises to startup ventures committed in Industrial,Semiconductor, Automotive, IoT , Defence and Aerospace.

Our mission is to help leading corporations and individuals, create and enhance efficient IT landscapes using various technologies that improve process and productive. More than mere tools, our process clearly aims at supporting people in maximizing their benefits and reduce the risk of failures."
                }
                function open(){
                    visible = true
                }

            }
        }
    }

    Image {
        x: -5
        y: -3
        sourceSize.width: 0
        opacity: 0.9
        anchors.bottomMargin: 290
        source: "../../../../snap/skype/common/ANCIT Logo.gif"
        anchors.fill: parent
        anchors.rightMargin: 122
        fillMode: Image.PreserveAspectFit
        anchors.leftMargin: 122
        anchors.topMargin: 64
    }

    ToolBar {
        x: 0
        y: 0
        width: 665
        height: 30
        visible: true

        ToolButton {
            id: btn_canSenderTab
            x: 161
            y: -1
            width: 160
            height: 30
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
            height: 30
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
            height: 29
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



    Item {
        id: w_busConfTab
        x: 168
        y: 119
        //flags: Qt.Popup
        width: 314
        height: 262
        opacity: 1
        visible: false
        //color: "#c5cad1"
        //title: qsTr("BUS CONFIGURATION")


        Rectangle {
            id: rectangle1
            x: 0
            y: 0
            width: 314
            height: 254
            color: "#e9e4e4"
            radius: 16
            border.width: 2
        }

        Button {
            id: send_button
            x: 99
            y: 216
            text: qsTr("CONFIGURE")
            onClicked: testWindow.getBUS_configuration();
        }



        Text {
            id: channel
            x: 26
            y: 95
            width: 112
            height: 36
            color: "#000000"
            text: qsTr("CHANNEL")
            font.weight: Font.DemiBold
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 15
        }

        Text {
            id: bit_rate
            x: 26
            y: 165
            width: 112
            height: 36
            color: "#000000"
            text: qsTr("BIT RATE")
            font.weight: Font.DemiBold
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 15
        }


        Text {
            id: bus_type
            x: 26
            y: 26
            width: 112
            height: 36
            color: "#000000"
            text: "BUS TYPE"
            font.weight: Font.DemiBold
            styleColor: "#000000"
            verticalAlignment: Text.AlignVCenter
            renderType: Text.NativeRendering
            textFormat: Text.RichText
            fontSizeMode: Text.FixedSize
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 15
        }


        TextField {
            objectName: "bitrate_in"
            id: bitrate_Input
            x: 177
            y: 165
            width: 105
            height: 30
            text: "250000"
            placeholderText: qsTr("bitrate")
        }

        ComboBox {
            objectName: "bustype_in"
            id: bustype1
            x: 177
            y: 26
            width: 105
            height: 30
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
            x: 177
            y: 95
            width: 105
            height: 30
        }

        Button {
            id: buttonn
            x: 208
            y: 215
            text: qsTr("SEND TEST")
            onClicked: testWindow.send_can();
        }

    }



    Item {
        id:w_canSenderTab
        x: 10
        y: 36
        //flags: Qt.Popup
        width:622
        height:405
        visible: false
        //color: "#fafafa"
        //title: qsTr("Can Raw Message Sender")

        Rectangle {
            id: rectangle
            x: -6
            y: 1
            width: 657
            height: 391
            color: "#e9e4e4"
            radius: 16
            border.width: 2
        }

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
            x: 27
            y: 55
            width: 592
            height: 319
            rotation: 0
            z: 0
            clip: false
            visible: true
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
                            if (!acceptableInput) print("Input not acceptable")
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
                            if (!acceptableInput) print("Input not acceptable")
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
                            if (!acceptableInput) print("Input not acceptable")
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
            x: 27
            y: 19
            width: 76
            height: 30
            text: qsTr("Add Row")
            rotation: 0
            visible: true
            //creating new ListModel row
            onClicked: {
                canDataModel.append({"canID" : "", "message" : " ", "period" : " "})
            }
        }



    }

    Item {
        id: w_canViewerTab
        x: 10
        y: 36
        objectName: "viewWindow"
        visible:false
        width: 649
        height: 400

        Rectangle {
            id: rectangle2
            x: -6
            y: 1
            width: 657
            height: 391
            color: "#e9e4e4"
            radius: 16
            border.width: 2
        }

        TextArea {
            objectName: "viewPanelText"
            id: viewPanel
            readOnly: true
            x: 0
            y: 49
            width: 645
            //width: 780
            //height: 293
            height: 311
            text: qsTr("")
            textColor: "#00000000"
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
            id: btn_playPause
            x: 240
            y: 364
            width: 142
            height: 22
            text: qsTr("Play")
            checked: false
            checkable: true
            onClicked: {
                if(btn_playPause.checked)
                {
                    viewPanel.append("Play Button Pressed")
                    btn_playPause.text = qsTr("Pause")
                    testWindow.playCanView();
                }
                else
                {
                    viewPanel.append("Pause Button Pressed")
                    btn_playPause.text = qsTr("Play")
                    testWindow.pauseCanView();
                }
            }

        }

        Label {
            id: label
            x: -4
            y: 8
            width: 513
            height: 43
            text: qsTr("Count	Time	Diff.Time	CAN ID	DLC	CAN Message
            ")
            visible: true
            color: "#020202"
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
        }


    }





}
