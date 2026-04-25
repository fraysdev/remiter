import QtQuick
import QtQuick.Layouts

import "../commons"

Item {
    id: root
    implicitHeight: 26

    Rectangle {
        id: modeTitle
        anchors.left: root.left
        anchors.verticalCenter: root.verticalCenter
        implicitWidth: modeLayout.width + 8
        implicitHeight: modeLayout.height
        color: "#303030"
        radius: 5

        RowLayout {
            id: modeLayout
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            RowLayout {
                Layout.fillWidth: true
                spacing: 0

                CButton {
                    iconSource: "modules/timer.svg"
                    onClicked: {
                        modeText.text = "Timer"
                        mainWindow.currentMode = 0
                    }
                    background: Rectangle {
                        color: "#404040"
                        topLeftRadius: 5
                        bottomLeftRadius: 5
                    }
                }
                CButton {
                    iconSource: "modules/stopwatch.svg"
                    onClicked: {
                        modeText.text = "Stopwatch"
                        mainWindow.currentMode = 1
                    }
                    background: Rectangle {
                        color: "#404040"
                        topRightRadius: 5
                        bottomRightRadius: 5
                    }
                }
            }

            CText {
                id: modeText
                Layout.alignment: Qt.AlignVCenter
                text: "Timer"
                font.pixelSize: 14
            }
        }
    }

    Rectangle {
        id: popupControl
        anchors.right: root.right
        anchors.verticalCenter: root.verticalCenter
        implicitWidth: popupCLayout.width + 8
        implicitHeight: popupCLayout.height
        color: "#303030"
        radius: 5

        RowLayout {
            id: popupCLayout
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            spacing: 8

            CText {
                Layout.alignment: Qt.AlignVCenter
                text: {
                    if (!popupTime.visible) return "Hidden"
                    return popupTime.alwaysOnTop ? "Locked" : "Unlocked"
                }
                font.pixelSize: 14
            }

            CButton {
                iconSource: {
                    if (!popupTime.visible) return "windows/show.svg"
                    return popupTime.alwaysOnTop ? "windows/lock.svg" : "windows/unlock.svg"
                }
                onClicked: {
                    if (!popupTime.visible) {
                        popupTime.show()
                        return
                    }
                    popupTime.alwaysOnTop = !popupTime.alwaysOnTop
                }
                background: Rectangle {
                    color: "#404040"
                    radius: 5
                }
            }
        }
    }

    // RowLayout {
    //     id: appButton
    //     anchors.right: root.right
    //     anchors.verticalCenter: root.verticalCenter
    //     spacing: 0

    //     CButton {
    //         iconSource: {
    //             if (!popupTime.visible) return "windows/show.svg"
    //             return popupTime.alwaysOnTop ? "windows/lock.svg" : "windows/unlock.svg"
    //         }
    //         onClicked: {
    //             if (!popupTime.visible) {
    //                 popupTime.show()
    //                 return
    //             }
    //             popupTime.alwaysOnTop = !popupTime.alwaysOnTop
    //         }
    //     }
    // }
}
