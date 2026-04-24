import QtQuick
import QtQuick.Layouts
import QtQuick.VectorImage

import "popups"

Window {
    id: root
    width: 350
    height: 116
    visible: true
    color: "#202020"
    title: "Retimer - Time"

    StackLayout {
        currentIndex: mainWindow.currentMode
        anchors.fill: parent

        Loader {
            active: mainWindow.currentMode === 0
            sourceComponent: TimerPopup {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
        Loader {
            active: mainWindow.currentMode === 1
            sourceComponent: StopwatchPopup {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
