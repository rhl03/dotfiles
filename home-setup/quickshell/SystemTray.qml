pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

Row {
    id: root
    spacing: 6

    Repeater {
        model: SystemTray.items
        delegate: Item {
            required property SystemTrayItem modelData
            implicitWidth: 22
            implicitHeight: 22

            Image {
                anchors.centerIn: parent
                source: modelData.icon
                width: 16
                height: 16
                smooth: true
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                onClicked: mouse => {
                    if (mouse.button === Qt.RightButton) {
                        modelData.secondaryActivate()
                    } else {
                        modelData.activate()
                    }
                }
            }
        }
    }
}
