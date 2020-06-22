import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles.Desktop 1.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.2
import Qt.labs.folderlistmodel 2.2
import QtGraphicalEffects.private 1.0

Window {  				 //Creating a plain window
    id: format_combo	//ID to identify
    visible: true		//Enabling visibility
    width: 850			// Required dimensions were provided
    height: 500
    color: "#ce9191"	// For background colour 
    title: qsTr("ANCIT EDB EDITOR")// Title of the window

// Adding button to do the task written in python
    Button {
        objectName: "browser_button"
        id: browse
        x: 685
        y: 44
        width: 120
        height: 35
        text: qsTr("Browse File") //  Text to be visible on button
        onClicked: {	// Once the button pressed the python function will be invoked
                edb.browse()
                textArea3.visible// the visibility of the particular widget is enable on clicking the button

        }
    }

 // Adding a text to just display
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

// Adding a text area to feed the necessary text to GUI from Python (path of the input file)

    TextArea{
    			   objectName: "INPUT_PATH"// using this object name in python script we can add text to GUI
                   id: textArea
                   x: 223
                   y: 44
                   width: 425
                   height: 38
                   text: edb.text
        }

 // Adding a text to just display
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
// Adding a drop down list which is called as "Combo Box"
    ComboBox {
        objectName: "output_format"//Object name to identify  widget and fetch the details chosen by the user
        id: comboBox
        x: 223
        y: 121
        width: 125
        height: 35
        model : [ 'arxml', 'csv', 'dbc', 'dbf', 'json', 'kcd', 'xml', 'sym', 'xls', 'yaml', 'py', 'lua']//The contents of the drop down list is given here
    }
    
    // Adding a text to just display
    
     Text {
        id: filename
        x: 24
        y: 190
        width: 123
        height: 36
        text: qsTr("Output File Name")// this text will be displayed in GUI
        font.weight: Font.DemiBold
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 17
     }
 // Adding a text field to get user response as a text
     TextField {
        objectName: "output_in"//Object name to identify the widget and fetch the details given by the user 
        id: output_filename
        x: 223
        y: 190
        width: 425
        height: 36
        placeholderText: qsTr("File name without extension")//This text will be displayed on the empty space for the understanding of user
     }
     
  // Adding button to do the task written in python
     Button {
         id: convert
        x: 685
        y: 365
        width: 120
        height: 35
        text: qsTr("CONVERT") //  Text to be visible on button
        onClicked:{ 
        
        	edb.convert_()		// Once the button pressed the python function will be invoked
        	textArea3.visible = true  //the text area is only visible when the button is clicked
        
        }
     }
// Adding button to do the task written in python
     Button {
         objectName: "browser_button2"
         id: browse2
         x: 685
         y: 279
         width: 120
         height: 35
         text: qsTr("Browse Path") //  Text to be visible on button
         onClicked: edb.browse_1();// Once the button pressed the python function will be invoked
     }

 // Adding a text to just display
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

// Adding a text area to feed the necessary text to GUI from Python (path of the directory)
	TextArea{
                    objectName: "viewPanelText" //Object name to identify the widget and fetch the details given by the user 
                    id: textArea2
                    x: 223
                    y: 279
                    width: 425
                    height: 38

    }
    
// Adding a text area to feed the necessary text to GUI from Python  (path of the converted file)
    TextArea {
        objectName: "console"//Object name to identify the widget and fetch the details given by the user 
        id: textArea3
        x: 223
        y: 365
        width: 425
        height: 84
        visible: false //initially the visibility is unable., on particular action it will be enable
    }


}


