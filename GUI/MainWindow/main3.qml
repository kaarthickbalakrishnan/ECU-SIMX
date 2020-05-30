import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects.private 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.5
import QtQuick.Extras 1.2

ApplicationWindow {
        visible: true
        width: 642
        height: 480
        title: ("Main Window")

        Button {
            id: sub
            x: 66
            y: 11
            text:"Can Device"

            onClicked: {
                mainMenu.popup();
            }

            StackView {
                id: stack
                anchors.fill: parent
            }





        Component {
    id:first

            Loader {

                sourceComponent: Window {
                    width: 430
                    height: 300
                    visible: true
                    title: ("Bus Configuration")
            }
        }

  }



         Menu {
         id:mainMenu

         MenuItem {
             text: "Bus Configuration"

              onTriggered: {
                 sub.text="Can Device";
                 stack.push(first);
              }

             }

        MenuItem {
            text:  "Can send"

            onTriggered:  {
                sub.text="Can Device";
                stack.push(second);
            }
        }


        MenuItem {
            text: "Can Receive"

            onTriggered:  {
                sub.text="Can Device";
                stack.push(third);
            }
        }

        }
      }
        Component {
            id: second


            Loader {


                sourceComponent: Window {
                    width:430
                    height: 300
                    visible: true
                    title: ("Can Send")
                }
            }
        }
        Component {
            id:third


            Loader {

                sourceComponent: Window {
                    width:430
                    height: 300
                    visible: true
                    title: ("Can Receive")
                }

        }
}

}
