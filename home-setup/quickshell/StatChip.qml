pragma ComponentBehavior: Bound
import QtQuick

Item {
    id: root
    required property string icon
    property var popup: null
    implicitWidth: 22
    implicitHeight: 22

    Text {
        anchors.centerIn: parent
        text: root.icon
        color: "#c0caf5"
        font.pixelSize: 15
        font.family: "Maple Mono NF"
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.popup?.toggle()
    }
}
