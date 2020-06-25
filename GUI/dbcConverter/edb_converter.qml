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
    width: 375
    height: 510
    
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
                //onTriggered: myWindow.open();//will open a child window
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
        height: 151
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
               id: inputPath_text
               x: 137
               y: 13
               width: 186
               height: 25
               text: ""
            }

            Button {
                Layout.row: 1
                objectName: "browser_button"
                id: browse
                x: 137
                y: 46
                width: 90
                text: qsTr("Browse File")
                onClicked: {
                        edb.browse_in()
                }
            }

            Button {
                id: newTemp
                x: 233
                y: 47
                width: 90
                text: qsTr("New File")
                objectName: "new_button"
                onClicked: {
                    edb.excel();
                }
            }

            Button {
                x: 137
                y: 78
                width: 186
                height: 25
                text: qsTr("Edit File")
                onClicked:edb.edit_();
            }
    }

        GroupBox {
            id: groupBoxOut
            x: 15
            y: 179
            width: 344
            height: 300
            title: qsTr("Output")

                Text {
                    id: fileFormat
                    x: 0
                    y: 13
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
                    x: 137
                    y: 10
                    width: 90
                    model : [ 'dbc', 'csv', 'kcd', 'dbf', 'arxml', 'json', 'xml', 'sym', 'xls', 'yaml', 'py', 'lua']
                }
                 Button {
                    id: convert
                    x: 89
                    y: 128
                    width: 150
                    text: qsTr("CONVERT")
                    onClicked:{
                        edb.convert_()
                    }
                 }


                TextField {
                    objectName: "outputPath"
                    id: textArea2
                    x: 137
                    y: 54
                    width: 186
                    height: 25
                }

                Button {
                    objectName: "browser_button2"
                    id: browse2
                    x: 137
                    y: 85
                    width: 90
                    text: qsTr("Browse")
                    onClicked: edb.browse_out();// Once the button pressed the python function will be invoked
                }

                TextArea {
                    objectName: "console"
                    id: textArea3
                    x: 7
                    y: 175
                    width: 312
                    height: 84
                    readOnly: true
                    visible: true
                }

                Text {
                    id: ouputdirectory
                    x: 0
                    y: 48
                    width: 112
                    height: 36
                    text: qsTr("Ouput File")
                    font.bold: false
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.weight: Font.DemiBold
                }

                Text {
                    id: fileFormat1
                    x: 8
                    y: 151
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

}
