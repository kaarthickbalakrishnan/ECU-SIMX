import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

ApplicationWindow {

    visible:true
    width: 640
    height: 500
    title: "MAIN WINDOW"

   header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("⋮")
                onClicked: menu.open();

            }
            Label {
                id: sub
                text: "Can device"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                text: qsTr("‹")
                onClicked:  {
                    stack.pop();
                }

            }
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
    }
    Menu {
        id: menu

        MenuItem {
            text: "Bus Configuration"

            onClicked:  {

                sub.text="BUS CONFIGURATION";
                stack.push(element);
            }


        }

        MenuItem {
            text: "Can Send"

            onClicked: {

                sub.text="CAN SEND";
                stack.push(secele);
            }

        }

        MenuItem {
            text: "Can Receive"
            onClicked:  {

                sub.text="CAN RECEIVE";
                stack.push(third);
            }

        }
    }

    Component {
        id:element

        Rectangle {
            x:187
            y:140
            width:200
            height:200
            anchors.fill: parent
            color: "red"

        }
    }
    Component {
        id:secele

        Rectangle {
            x:187
            y:140
            width:200
            height:200
            anchors.fill: parent
            color: 'blue'

        }
     }
    Component {
        id:third

        Rectangle {
            x:187
            y:140
            width:200
            height:200
            anchors.fill: parent
            color: "Yellow"
        }
    }
}
