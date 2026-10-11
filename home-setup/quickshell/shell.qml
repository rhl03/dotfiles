import Quickshell
import Quickshell.Io
import QtQuick

ShellRoot {
    IpcHandler {
        target: "launcher"
        function toggle() {}
    }

    Variants {
        model: [Quickshell.screens[0]]
        delegate: BarWindow {
            required property var modelData
        }
    }
}
