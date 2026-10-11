pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Window {
    id: root
    visible: false
    width: 280
    height: 120
    flags: Qt.Popup | Qt.FramelessWindowHint
    color: "transparent"
    y: 46

    Component.onCompleted: x = 1625

    property int volume: 50
    property bool muted: false

    Timer {
        id: closeTimer
        interval: 200
        onTriggered: if (!root.active) root.visible = false
    }

    onActiveChanged: if (!active) closeTimer.start()

    Process {
        id: getVolume
        command: ["sh", "-c", "pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | head -1"]
        stdout: SplitParser { onRead: data => root.volume = parseInt(data.trim()) }
    }

    Process {
        id: getMuted
        command: ["sh", "-c", "pactl get-sink-mute @DEFAULT_SINK@"]
        stdout: SplitParser { onRead: data => root.muted = data.includes("yes") }
    }

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: "#1a1b26"
        border.color: "#3b4261"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                Text {
                    text: "Audio"
                    color: "#c0caf5"
                    font.pixelSize: 14
                    font.bold: true
                    font.family: "Maple Mono NF"
                }
                Item { Layout.fillWidth: true }
                Text {
                    text: root.muted ? "󰖁" : "󰕾"
                    color: root.muted ? "#565f89" : "#c0caf5"
                    font.pixelSize: 16
                    font.family: "Maple Mono NF"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"])
                            getMuted.running = true
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Text {
                    text: root.volume + "%"
                    color: "#a9b1d6"
                    font.pixelSize: 12
                    font.family: "Maple Mono NF"
                    Layout.minimumWidth: 36
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 8
                    radius: 4
                    color: "#3b4261"

                    Rectangle {
                        width: parent.width * (root.volume / 100)
                        height: parent.height
                        radius: 4
                        color: "#7aa2f7"
                        Behavior on width { NumberAnimation { duration: 100 } }
                    }

                    MouseArea {
                        anchors.fill: parent
                        anchors.topMargin: -8
                        anchors.bottomMargin: -8
                        onClicked: {
                            let vol = Math.min(100, Math.max(0, Math.round(mouseX / width * 100)))
                            Quickshell.execDetached(["pactl", "set-sink-volume", "@DEFAULT_SINK@", vol + "%"])
                            root.volume = vol
                        }
                        onPositionChanged: {
                            if (pressed) {
                                let vol = Math.min(100, Math.max(0, Math.round(mouseX / width * 100)))
                                Quickshell.execDetached(["pactl", "set-sink-volume", "@DEFAULT_SINK@", vol + "%"])
                                root.volume = vol
                            }
                        }
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }

    function toggle() {
        if (!visible) {
            getVolume.running = true
            getMuted.running = true
        }
        visible = !visible
    }
}
