import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.0
import QtQuick.Extras 1.2

Window {              //Creating a plain window
    id: sendbutton   //ID to identify
    visible: true    //Enabling visibility
    width: 370		// Required dimensions were provided
    height: 320
    color: "#c5cad1"  // For background colour 
    title: qsTr("BUS CONFIGURATION") // Title of the window

		//Adding a new button 
   
    Button {
        id: send_button
        x: 139
        y: 260
        text: qsTr("CONFIGURE")  //  Text to be visible on button
        onClicked: busconfigure.getBUS_configuration(); // Once the button pressed the python function will be invoked
    }

    // Adding a text to just display
	

    Text {
        id: channel
        x: 21
        y: 116
        width: 112
        height: 36
        text: qsTr("CHANNEL")  // The given text will be displayed 
        font.weight: Font.DemiBold   //These option are for the look and feel of the text
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

   // Adding a text field to get user response as a text

    TextField {
        objectName: "bitrate_in" //Object name to identify and fetch the details given by the user 
        id: bitrate_Input
        x: 172
        y: 186
        width: 125
        height: 36
        placeholderText: qsTr("bitrate") //This text will be displayed for the understanding of user
    }


	// Adding a drop down list which is called as "Combo Box"
    ComboBox {
        objectName: "bustype_in" //Object name to identify and fetch the details given by the user
        id: bustype1
        x: 172
        y: 47
        width: 125
        height: 36
        model: ["socketcan","virtual"] //The contents of the drop down list is given here
        onCurrentIndexChanged:    // According to the value of the bustype the respective channels will be listed in another combo box
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
            id: button
         	x: 247
       	    y: 260
            text: qsTr("SEND TEST")
            onClicked: busconfigure.send_can();
        }
}
