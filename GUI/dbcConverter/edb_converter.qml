import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles.Desktop 1.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.2
import Qt.labs.folderlistmodel 2.2
import QtGraphicalEffects.private 1.0

Window {
    id: format_combo
    visible: true
    width: 850
    height: 500
    color: "#ce9191"
    title: qsTr("ANCIT EDB EDITOR")

    Button {
        objectName: "browser_button"
        id: browse
        x: 685
        y: 44
        width: 120
        height: 35
        text: qsTr("Browse File")
        onClicked: {
                edb.browse()
                textArea3.visible

        }
    }

    Text {
       id: inputfilename
       x: 18
       y: 41
       width: 150
       height: 36
       text: qsTr("Input File")
       font.weight: Font.DemiBold
       verticalAlignment: Text.AlignVCenter
       horizontalAlignment: Text.AlignLeft
       font.pixelSize: 17
    }

    TextArea{
    			   objectName: "INPUT_PATH"
                   id: textArea
                   x: 223
                   y: 44
                   width: 425
                   height: 38
                   text: edb.text
        }

    TextInput {
        id: file_format
        x: 18
        y: 121
        width: 120
        height: 35
        text: qsTr("Output Format")
        font.weight: Font.DemiBold
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 17
    }

    ComboBox {
        objectName: "output_format"
        id: comboBox
        x: 223
        y: 121
        width: 125
        height: 35
        model : [ 'arxml', 'csv', 'dbc', 'dbf', 'json', 'kcd', 'xml', 'sym', 'xls', 'yaml', 'py', 'lua']
    }
     Text {
        id: filename
        x: 24
        y: 190
        width: 123
        height: 36
        text: qsTr("Output File Name")
        font.weight: Font.DemiBold
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 17
     }

     TextField {
        objectName: "output_in"
        id: output_filename
        x: 223
        y: 190
        width: 425
        height: 36
        placeholderText: qsTr("File name without extension")
     }
     Button {
         id: convert
        x: 685
        y: 365
        width: 120
        height: 35
        text: qsTr("CONVERT")
        onClicked:{ 
        
        	edb.convert_()
        	textArea3.visible = true
        
        }
     }

     Button {
         objectName: "browser_button2"
         id: browse2
         x: 685
         y: 279
         width: 120
         height: 35
         text: qsTr("Browse Path")
         onClicked: edb.browse_1();
     }

     Text {
         id: ouputdirectory
         x: 18
         y: 271
         width: 150
         height: 36
         text: qsTr("Choose Output Directory")
         verticalAlignment: Text.AlignVCenter
         font.pixelSize: 17
         horizontalAlignment: Text.AlignLeft
         font.weight: Font.DemiBold
     }

	TextArea{
                    objectName: "viewPanelText"
                    id: textArea2
                    x: 223
                    y: 279
                    width: 425
                    height: 38

    }

    TextArea {
        objectName: "console"
        id: textArea3
        x: 223
        y: 365
        width: 425
        height: 84
        visible: false
    }


}


