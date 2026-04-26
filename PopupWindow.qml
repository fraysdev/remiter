import QtQuick
import QtQuick.Layouts
import QtQuick.VectorImage

import "popups"

Window {
    id: root
    width: fontMetrics.maximumCharacterWidth * 53 + 20
    height: fontMetrics.height * 8 + 20
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

    FontMetrics {
        id: fontMetrics
        font.family: Style.timeFont
    }

    StackLayout {
        currentIndex: mainWindow.currentMode
        anchors.fill: parent

        Loader {
            active: mainWindow.currentMode === 0
            sourceComponent: TimerPopup {
                maximize: root.visibility === Window.Maximized
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
        Loader {
            active: mainWindow.currentMode === 1
            sourceComponent: StopwatchPopup {
                maximize: root.visibility === Window.Maximized
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
