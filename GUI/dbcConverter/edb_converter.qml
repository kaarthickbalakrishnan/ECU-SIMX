import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles.Desktop 1.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.2
import Qt.labs.folderlistmodel 2.2
import QtGraphicalEffects.private 1.0
import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Window 2.0

ApplicationWindow {
    visible:true
    id:window
    title: "EDB Devoloper"
    width: 375
    height: 546
    
    Image {
        id: image
        x: 248
        y: 3
        width: 110
        height: 37
        fillMode: Image.PreserveAspectCrop
        source: "ANCIT Logo.gif"
    }
    
    menuBar: MenuBar {

        Menu {
            title: "File"
            MenuItem {
                text: "New"
                onTriggered:  {
                    var component = Qt.createComponent("edb_converter.qml")
                    var window    = component.createObject()
                    window.show()
                }
            }
            MenuItem {
                text: "Quit"
                onTriggered: window.close();//will close the full application
            }


            Window{   //window used in open menuitem
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
                onTriggered: edb.viewHelpDoc();
            }
            MenuItem {
                text: "About"
                onTriggered: win.open();

            }
            Window{//window used in about content ...contents to be added
                id: win
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
    GroupBox {
        id: groupBoxIn
        x: 13
        y: 22
        width: 346
        height: 180
        title: qsTr("SIgnal Database Input")

        Text {
            id: inputfilename
            x: 0
            y: 51
            width: groupBoxIn.width / 3
            text: qsTr("Locate Path")
            Layout.fillWidth: false
            font.bold: false
            font.weight: Font.DemiBold
            font.pixelSize: 13
        }

        TextField {
            objectName: "inputPath"
            id: inputPath_text
            x: 137
            y: 47
            width: 156
            height: 25
            text: ""
        }

        Button {
            Layout.row: 1
            objectName: "browser_create"
            id: browseCreate
            x: 300
            y: 47
            width: 20
            height: 25
            text: qsTr("...")
            onClicked: edb.browse_create()
        }
        Button {
            Layout.row: 1
            objectName: "browser_edit"
            id: browseEdit
            x: 300
            y: 47
            width: 20
            height: 25
            text: qsTr("...")
            visible: false
            onClicked: {
                edb.browse()
            }
        }

        Text {
            id: inputfilename3
            x: 0
            y: 86
            width: groupBoxIn.width / 3
            text: qsTr("File Name")
            font.pixelSize: 13
            font.weight: Font.DemiBold
            font.bold: false
            Layout.fillWidth: false
        }

        TextField {
            id: createFileName
            objectName: "newFileName"
            x: 137
            y: 81
            width: 156
            height: 25
            text: "Sample"
        }

        Button {
            id: exec_Btn
            x: 112
            y: 121
            width: 106
            height: 22
            text: qsTr("Execute")
            onClicked:edb.exec_fn();
        }

        ComboBox {
            id: fn_comboBox
            x: 137
            y: 10
            width: 107
            height: 25
            objectName: "function_select"
            model: ['Converter', 'Editor', 'Create']
            onCurrentIndexChanged:{
                if(currentText == "Create") {
                    textArea3.text = qsTr("Create")
                    groupBoxOut.visible = false
                    browseEdit.visible = false
                    createFileName.visible = true
                    inputfilename3.visible = true
                    exec_Btn.visible = true
                    inputfilename2.visible = false
                }
                if(currentText == "Editor") {
                    textArea3.text = qsTr("Editor button")
                    groupBoxOut.visible = false
                    browseEdit.visible = true
                    createFileName.visible = false
                    inputfilename3.visible = false
                    exec_Btn.visible = true
                    inputfilename2.visible = true
                }
                if(currentText == "Converter") {
                    textArea3.text = qsTr("Converter")
                    groupBoxOut.visible = true
                    browseEdit.visible = true
                    createFileName.visible = false
                    inputfilename3.visible = false
                    exec_Btn.visible = false
                    inputfilename2.visible = true

                }
            }
        }

        Text {
            id: inputfilename1
            x: 0
            y: 15
            width: groupBoxIn.width / 3
            text: qsTr("Function")
            Layout.fillWidth: false
            font.bold: false
            font.weight: Font.DemiBold
            font.pixelSize: 13
        }

        Text {
            id: inputfilename2
            x: 1
            y: 66
            width: groupBoxIn.width / 3
            text: qsTr("Supported File (xlsx)")
            Layout.fillWidth: false
            font.bold: false
            font.weight: Font.DemiBold
            font.pixelSize: 10
        }
    }

    GroupBox {
        id: groupBoxOut
        x: 15
        y: 208
        width: 344
        height: 269
        visible: true
        title: qsTr("EDB Developer Output")

        Text {
            id: fileFormat
            x: 0
            y: 13
            width: groupBoxOut.width / 4
            text: qsTr("Database Format")
            font.bold: false
            font.pixelSize: 13
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.weight: Font.DemiBold
        }

        ComboBox {
            objectName: "output_format"
            id: comboBox
            x: 137
            y: 10
            width: 90
            model : [ 'dbc', 'csv', 'kcd', 'dbf', 'arxml', 'json', 'xml', 'sym', 'xls', 'yaml', 'py', 'lua']
        }
        Button {
            id: convert
            x: 89
            y: 124
            width: 150
            text: qsTr("Execute")
            onClicked:{
                edb.convert_()
            }
        }

        Text {
            id: ouputname
            x: 0
            y: 44
            width: 112
            height: 36
            text: qsTr("File Name")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 13
            horizontalAlignment: Text.AlignLeft
            font.weight: Font.DemiBold
            font.bold: false
        }

        TextField {
            id: outName
            objectName: "outFilename"
            x: 137
            y: 49
            width: 156
            height: 25
            text: "Sample"
        }
        TextField {
            objectName: "outputPath"
            id: textArea2
            x: 137
            y: 84
            width: 156
            height: 25
        }

        Button {
            objectName: "browser_button2"
            id: browse2
            x: 300
            y: 84
            width: 20
            text: qsTr("...")
            onClicked: edb.browse_out();// Once the button pressed the python function will be invoked
        }

        TextArea {
            objectName: "console"
            id: textArea3
            x: 7
            y: 170
            width: 312
            height: 62
            readOnly: true
            visible: true
        }

        Text {
            id: ouputdirectory
            x: 0
            y: 78
            width: 112
            height: 36
            text: qsTr("Locate Path")
            font.bold: false
            font.pixelSize: 13
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.weight: Font.DemiBold
        }

        Text {
            id: fileFormat1
            x: 8
            y: 147
            width: 150
            height: 25
            text: qsTr("Status")
            font.bold: false
            font.pixelSize: 13
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.weight: Font.DemiBold
        }

    }

    GroupBox {
        id: groupBoxAncit
        x: 15
        y: 465
        width: 344
        height: 51

        Text {
            id: devBy
            x: 74
            y: 18
            width: 103
            height: 25
            text: qsTr("Developed By")
            font.bold: true
            font.pixelSize: 13
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            font.weight: Font.DemiBold
        }

        Image {
            id: ancitLogo
            x: 165
            y: 19
            width: 81
            height: 23
            fillMode: Image.PreserveAspectCrop
            source: "ANCIT Logo.gif"
        }
    }
}
