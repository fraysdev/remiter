import QtQuick
import QtQuick.Layouts

import "../commons"

Item {
    id: root
    implicitHeight: 26

    RowLayout {
        id: modeTitle
        anchors.left: root.left
        anchors.verticalCenter: root.verticalCenter
        spacing: 8

        RowLayout {
            CButton {
                iconSource: "left.svg"
            }

            CButton {
                iconSource: "right.svg"
            }
        }


        CText {
            anchors.leftMargin: 4
            text: "Timer"
            font.pixelSize: 14
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
