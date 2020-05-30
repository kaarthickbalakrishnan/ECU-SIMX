import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls 2.2

Window {
    id: canSend
    visible: true
    width: 450
    height: 150
    color: "#efefef"
    title: qsTr("Can Sender")

    // Signal argument names are not propagated from Python to QML, so we need to re-emit the signal
//    signal reNextNumber(int number)
//    Component.onCompleted: canSender.nextNumber.connect(reNextNumber)

            Button {
                id: sendBtn
                x: 202
                y: 63
                width: 68
                height: 23
                text: qsTr("Send")
                onClicked: testWindow.sendBtn_Click();
            }

            Text {
                id: text1
                x: 39
                y: 40
                text: qsTr("Can ID")
                font.pixelSize: 12
            }

            TextField {
                objectName: "canID_in"
                id: id_Input
                x: 15
                y: 61
                width: 83
                height: 27
            }


//            Text {
//                id: textCheck
//                x: 229
//                y: 136
//                width: 114
//                height: 28
//                text: qsTr("Text")
//                font.pixelSize: 12
//            }

//            Button {
//                id: btn1
//                x: 404
//                y: 130
//                width: 77
//                height: 22
//                text: qsTr("Get Num")
//                onClicked: canSender.giveNumber();
//            }

//    Connections {
//        target: canSend
//        onReNextNumber: textCheck.text = number
//    }
}

