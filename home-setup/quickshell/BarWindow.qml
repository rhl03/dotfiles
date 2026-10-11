pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Scope {
    id: root

    AudioPopup {
        id: audioPopup
    }

    CalendarPopup {
        id: calendarPopup
    }

    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        exclusiveZone: barContainer.height
        implicitHeight: barContainer.height
        color: "transparent"

        Rectangle {
            id: barContainer
            width: parent.width
            height: 42
            color: "#191724"

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: 1
                color: "#26233a"
            }

            BarContent {
                anchors.fill: parent
                audioPopup: audioPopup
                calendarPopup: calendarPopup
            }
        }
    }
}
