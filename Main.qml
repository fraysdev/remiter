import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "windows"
import "commons"
import "components"

Window {
    id: root
    width: 500
    height: 600
    visible: true
    color: "#202020"
    title: "Retimer - Config@Timer"

    FontLoader { source: "assets/fonts/Sen.ttf" }
    FontLoader { source: "assets/fonts/InputMono-Black.ttf" }
    FontLoader { source: "assets/fonts/InputMono-Bold.ttf" }
    FontLoader { source: "assets/fonts/InputMono-Medium.ttf" }
    FontLoader { source: "assets/fonts/InputMono-Regular.ttf" }
    FontLoader { source: "assets/fonts/InputMono-Thin.ttf" }
    FontLoader { source: "assets/fonts/InputMono-Light.ttf" }
    FontLoader { source: "assets/fonts/InputMono-ExtraLight.ttf" }

    PopupTime {
        id: popupTime
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 8
            Layout.leftMargin: 8
            Layout.rightMargin: 8

            CText {
                text: "Timer"
                font.pixelSize: 20
                font.weight: 700
                Layout.fillWidth: true
            }

            CButton {
                iconSource: "left.svg"
            }

            CButton {
                iconSource: "right.svg"
            }

            CButton {
                iconSource: {
                    if (!popupTime.visible) return "show.svg"
                    return "lock.svg"
                }
                text: {
                    if (!popupTime.visible) return "Show"
                    return "Lock"
                }
                onClicked: {
                    if (!popupTime.visible) {
                        popupTime.show()
                    }

                    console.log("Lock")
                }
            }
        }

        TimerControl {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.bottomMargin: 8
        }
    }
}
