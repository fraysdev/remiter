import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "commons"
import "components"
import "components/controls"

Window {
    id: mainWindow
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

    property int currentMode: 0

    PopupWindow {
        id: popupTime
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Titlebar {
            Layout.fillWidth: true
            Layout.margins: 8
        }

        Rectangle {
            color: "#808080"
            Layout.fillWidth: true
            Layout.preferredHeight: 1
        }

        StackLayout {
            currentIndex: mainWindow.currentMode
            Layout.margins: 8

            Loader {
                active: mainWindow.currentMode === 0
                sourceComponent: TimerControl {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
            Loader {
                active: mainWindow.currentMode === 1
                sourceComponent: StopwatchControl {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }
}
