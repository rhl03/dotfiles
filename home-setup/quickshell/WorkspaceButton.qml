pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import QtQuick

Item {
    id: root
    required property int wsId
    required property bool isActive
    required property bool isOccupied
    implicitWidth: 20
    implicitHeight: 20

    Rectangle {
        anchors.centerIn: parent
        width: root.isActive ? 12 : (root.isOccupied ? 7 : 4)
        height: width
        radius: width / 2
        opacity: root.isActive ? 1.0 : (root.isOccupied ? 0.5 : 0.15)
        color: "#c0caf5"

        Behavior on width   { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
        Behavior on opacity { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + root.wsId)
        cursorShape: Qt.PointingHandCursor
    }
}
