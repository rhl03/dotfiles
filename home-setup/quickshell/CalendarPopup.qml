pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Window {
    id: root
    visible: false
    width: 280
    height: 300
    flags: Qt.Popup | Qt.FramelessWindowHint
    color: "transparent"
    y: 46

    Component.onCompleted: x = (1920 - width) / 2

    property var now: new Date()
    property int displayMonth: now.getMonth()
    property int displayYear: now.getFullYear()

    function daysInMonth(month, year) {
        return new Date(year, month + 1, 0).getDate()
    }

function firstDayOfMonth(month, year) {
    let day = new Date(year, month, 1).getDay()
    return (day + 6) % 7
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
            spacing: 8

            // Month navigation
            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "󰄱"
                    color: "#c0caf5"
                    font.pixelSize: 14
                    font.family: "Maple Mono NF"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (root.displayMonth === 0) {
                                root.displayMonth = 11
                                root.displayYear--
                            } else {
                                root.displayMonth--
                            }
                        }
                    }
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: Qt.formatDate(new Date(root.displayYear, root.displayMonth, 1), "MMMM yyyy")
                    color: "#c0caf5"
                    font.pixelSize: 14
                    font.bold: true
                    font.family: "Maple Mono NF"
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "󰄲"
                    color: "#c0caf5"
                    font.pixelSize: 14
                    font.family: "Maple Mono NF"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (root.displayMonth === 11) {
                                root.displayMonth = 0
                                root.displayYear++
                            } else {
                                root.displayMonth++
                            }
                        }
                    }
                }
            }

            // Day headers
            Grid {
                Layout.fillWidth: true
                columns: 7
                spacing: 4

                Repeater {
                    model: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
                    Text {
                        required property string modelData
                        text: modelData
                        color: "#565f89"
                        font.pixelSize: 11
                        font.family: "Maple Mono NF"
                        width: (280 - 32 - 24) / 7
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }

            // Calendar grid
            Grid {
                Layout.fillWidth: true
                columns: 7
                spacing: 4

                Repeater {
                    model: 42
                    delegate: Item {
                        required property int index
                        width: (280 - 32 - 24) / 7
                        height: width

                        property int dayNum: index - root.firstDayOfMonth(root.displayMonth, root.displayYear) + 1
                        property bool validDay: dayNum >= 1 && dayNum <= root.daysInMonth(root.displayMonth, root.displayYear)
                        property bool isToday: validDay &&
                            dayNum === root.now.getDate() &&
                            root.displayMonth === root.now.getMonth() &&
                            root.displayYear === root.now.getFullYear()

                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width - 2
                            height: width
                            radius: width / 2
                            color: isToday ? "#7aa2f7" : "transparent"
                        }

                        Text {
                            anchors.centerIn: parent
                            text: validDay ? dayNum : ""
                            color: isToday ? "#1a1b26" : (validDay ? "#c0caf5" : "transparent")
                            font.pixelSize: 11
                            font.bold: isToday
                            font.family: "Maple Mono NF"
                        }
                    }
                }
            }

        }
    }

    function toggle() {
        root.now = new Date()
        root.displayMonth = root.now.getMonth()
        root.displayYear = root.now.getFullYear()
        visible = !visible
    }
}
