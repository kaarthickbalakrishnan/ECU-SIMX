import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.0
import QtQuick.Extras 1.2

Window {
    id: sendbutton
    visible: true
    width: 370
    height: 320
    color: "#c5cad1"
    title: qsTr("BUS CONFIGURATION")

   
    Button {
        id: send_button
        x: 139
        y: 260
        text: qsTr("CONFIGURE")
        onClicked: busconfigure.getBUS_configuration();
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
            id: button
         	x: 247
       	    y: 260
            text: qsTr("SEND TEST")
            onClicked: busconfigure.send_can();
        }
}
