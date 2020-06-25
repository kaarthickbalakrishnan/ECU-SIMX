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
    title: "ANCIT EDB EDITOR"
    width: 415
    height: 510
    
    Image {
        id: image
        x: 285
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
                text: "Open"
                onTriggered: myWindow.open();//will open a child window
            }
            MenuItem {
                text: "Close"
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
                 onTriggered:Qt.openUrlExternally("FIELDS IN EXCEL.odt")//url of file source to be mentioned
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
                function open(){
                    visible = true
                }

 			}
		}
    }

        GroupBox {
            id: groupBoxIn
            x: 16
            y: 22
            width: 379
            height: 129
            title: qsTr("Input")

                Text {
                   id: inputfilename
                   x: 0
                   y: 22
                   width: groupBoxIn.width / 3
                   text: qsTr("Input File")
                   Layout.fillWidth: false
                   font.bold: false
                   font.weight: Font.DemiBold
                   font.pixelSize: 13
                }

                TextField {
                   objectName: "inputPath"
                   width: groupBoxIn.width / 2
                   id: inputPath_text
                   x: 137
                   y: 13
                   height: 25
                   text: ""
                }

                Button {
                    Layout.row: 1
                    objectName: "browser_button"
                    id: browse
                    x: 137
                    y: 52
                    width: groupBoxIn.width / 4
                    text: qsTr("Browse File")
                    onClicked: {
                            edb.browse_in()
                    }
                }

                Button {
                    id: newTemp
                    x: 249
                    y: 52
                    width: groupBoxIn.width / 4
                    text: qsTr("New File")
                    objectName: "new_button"
                }
        }

        GroupBox {
            id: groupBoxOut
            x: 16
            y: 162
            width: 379
            height: 310
            title: qsTr("Output")

                Text {
                    id: fileFormat
                    x: 3
                    y: 5
                    width: groupBoxOut.width / 4
                    text: qsTr("File Format")
                    font.bold: false
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.weight: Font.DemiBold
                }

                ComboBox {
                    objectName: "output_format"
                    id: comboBox
                    x: 136
                    y: 12
                    width: groupBoxOut.width / 4
                    model : [ 'arxml', 'csv', 'dbc', 'dbf', 'json', 'kcd', 'xml', 'sym', 'xls', 'yaml', 'py', 'lua']
                }

                 TextField {
                    objectName: "output_in"
                    id: output_filename
                    x: 136
                    y: 47
                    width: groupBoxOut.width / 2
                    height: 25
                    placeholderText: qsTr("Name without extension")
                 }
                 Button {
                    id: convert
                    x: 184
                    y: 142
                    width: groupBoxOut.width / 4
                    text: qsTr("CONVERT")
                    onClicked:{
                        edb.convert_()
                    }
                 }


                TextField {
                    objectName: "outputPath"
                    id: textArea2
                    x: 136
                    y: 82
                    width: groupBoxOut.width / 3
                    height: 25
                }

                Button {
                    objectName: "browser_button2"
                    id: browse2
                    x: 280
                    y: 82
                    width: groupBoxOut.width / 6
                    text: qsTr("Browse")
                    onClicked: edb.browse_out();// Once the button pressed the python function will be invoked
                }

                TextArea {
                    objectName: "console"
                    id: textArea3
                    x: 0
                    y: 187
                    width: 336
                    height: 84
                    readOnly: true
                    visible: true
                }

                Text {
                    id: ouputdirectory
                    x: 3
                    y: 76
                    width: 112
                    height: 36
                    text: qsTr("Ouput Directory")
                    font.bold: false
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.weight: Font.DemiBold
                }

                Text {
                    id: filename
                    x: 3
                    y: 41
                    width: 112
                    height: 36
                    text: qsTr("File Name")
                    font.bold: false
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.weight: Font.DemiBold
                }

                Text {
                    id: fileFormat1
                    x: 0
                    y: 154
                    width: 150
                    height: 36
                    text: qsTr("Status")
                    font.bold: false
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.weight: Font.DemiBold
                }

            }


}

