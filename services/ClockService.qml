pragma Singleton
import QtQuick

QtObject {
    id: root

    readonly property alias currentTime: root._currentTime
    property var _currentTime: new Date()

    property var _sync: Timer {
        interval: 1000 - (new Date().getMilliseconds())
        repeat: false
        running: true
        onTriggered: {
            root._tick.start()
            root._updateTime()
        }
    }

    property var _tick: Timer {
        interval: 1000
        repeat: true
        running: false
        onTriggered: root._updateTime()
    }

    function _updateTime() {
        root._currentTime = new Date()
    }
}