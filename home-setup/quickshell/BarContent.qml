pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    property var audioPopup: null
    property var calendarPopup: null
    property var launcher: null

    readonly property int activeWsId: Hyprland.focusedMonitor?.activeWorkspace?.id ?? 1
    property var occupiedWs: ({})
    property bool networkConnected: false

    Process {
        id: checkNetwork
        command: ["sh", "-c", "nmcli -t -f STATE general | grep -c connected"]
        stdout: SplitParser { onRead: data => root.networkConnected = parseInt(data.trim()) > 0 }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: checkNetwork.running = true
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            let obj = {}
            let wsList = Hyprland.workspaces.values
            for (let i = 0; i < wsList.length; i++) {
                obj[wsList[i].id] = true
            }
            root.occupiedWs = obj
        }
    }

    // Left — Arch logo + Workspaces
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Text {
            text: "\uf303"
            font.family: "Maple Mono NF"
            font.pixelSize: 19
            color: "#c0caf5"
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.launcher?.toggle()
            }
        }

        Row {
            spacing: 4
            anchors.verticalCenter: parent.verticalCenter
            Repeater {
                model: 9
                delegate: WorkspaceButton {
                    required property int modelData
                    wsId: modelData + 1
                    isActive: (modelData + 1) === root.activeWsId
                    isOccupied: root.occupiedWs[modelData + 1] ?? false
                }
            }
        }
    }

    // Center — Clock
    Item {
        anchors.centerIn: parent

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockText.text = Qt.formatTime(new Date(), "hh:mm:ss")
        }

        Text {
            id: clockText
            anchors.centerIn: parent
            text: Qt.formatTime(new Date(), "hh:mm:ss")
            color: "#c0caf5"
            font.pixelSize: 15
            font.bold: true
            font.family: "Maple Mono NF"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.calendarPopup?.toggle()
            }
        }
    }

    // Right — Tray + Network + Audio
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        SystemTray {
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.networkConnected ? "󰤨" : "󰤭"
            color: root.networkConnected ? "#c0caf5" : "#565f89"
            font.pixelSize: 15
            font.family: "Maple Mono NF"
            anchors.verticalCenter: parent.verticalCenter

            Behavior on color { ColorAnimation { duration: 300 } }
        }

        StatChip { icon: "󰕾"; popup: root.audioPopup }
    }
}
