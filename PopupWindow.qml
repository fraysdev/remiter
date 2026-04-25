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

    property bool alwaysOnTop: false
    flags: Qt.Window
         | Qt.WindowTitleHint
         | Qt.WindowSystemMenuHint
         | Qt.WindowMinimizeButtonHint
         | Qt.WindowMaximizeButtonHint
         | Qt.WindowCloseButtonHint
         | (alwaysOnTop ? Qt.WindowStaysOnTopHint : Qt.Widget)
    transientParent: alwaysOnTop ? null : mainWindow

    Connections {
        target: mainWindow
        function onClosing() {
            root.close()
        }
    }

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
