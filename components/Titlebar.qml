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


    CText {
        id: appTitle
        anchors.centerIn: parent
        text: "Remiter"
        font.pixelSize: 16
        font.weight: 700
    }

    RowLayout {
        id: appButton
        anchors.right: root.right
        anchors.verticalCenter: root.verticalCenter
        spacing: 0

        CButtonless {
            iconSource: {
                if (!popupTime.visible) return "windows/show.svg"
                return "windows/unlock.svg"
            }
            onClicked: {
                if (!popupTime.visible) {
                    popupTime.show()
                }

                console.log("Lock")
            }
        }

        CButtonless {
            iconSource: "windows/minimize.svg"
            onClicked: mainWindow.showMinimized()
        }

        CButtonless {
            iconSource: "windows/close.svg"
            onClicked: mainWindow.close()
        }
    }
}
