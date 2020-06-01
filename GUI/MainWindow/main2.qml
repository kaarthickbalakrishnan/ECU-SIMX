import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects.private 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.5
import QtQuick.Extras 1.2

ApplicationWindow {
    visible: true
    width: 530
    height: 300
    title: ("Main Window")

Button {
    id: button
    x: 20
    y: 49
    text: qsTr("can bus_config")

    onClicked: winld.active = true


    Loader {
        id: winld
        active: false
        sourceComponent: Window {
            width: 430
            height: 300
            visible: true
            title: ("config_1")


        }
    }
}

Button {
    id: button1
    x: 20
    y: 100
    width: 109
    height: 25
    text: qsTr("can_send")
    onClicked: winld1.active = true

        Loader {
            id: winld1
            active: false
            sourceComponent: Window {
                width: 430
                height: 300
                visible: true
                title: ("can_sender_1")


            }
        }
}

Button {
    id: button2
    x: 20
    y: 152
    width: 109
    height: 25
    text: qsTr("can_recieve")
    onClicked: winld2.active = true

        Loader {
            id: winld2
            active: false
            sourceComponent: Window {
                width: 430
                height: 300
                visible: true
                title: ("can_receiver_1")


            }
        }
}
}
