// TimerService.qml
pragma Singleton
import QtQuick

QtObject {
    id: root

    // ── Public state ──────────────────────────────────────────────────────
    enum State {
        Idle,
        Running,
        Paused,
        Finished
    }

    property int state: TimerService.State.Idle
    property bool extending: false
    property int remaining: 0
    property int extend: 0

    // Derived display
    readonly property string display: {
        var s = Math.floor(remaining / 1000)
        var h = Math.floor(s / 3600)
        var m = Math.floor((s % 3600) / 60)
        var sec = s % 60
        return pad(h) + ":" + pad(m) + ":" + pad(sec)
    }

    // ── Public API ────────────────────────────────────────────────────────
    function start(duration, additional) {
        if (duration === undefined || duration <= 0) return

        remaining = duration
        extend = additional
        extending = false
        state = TimerService.State.Running
        _tick.running = true
        _lastTick = Date.now()
    }

    function toggleRunning() {
        if (TimerService.state === TimerService.State.Running)
            pause()
        else resume()
    }

    function pause() {
        state = TimerService.State.Paused
        _tick.stop()
    }

    function resume() {
        _lastTick = Date.now()
        state = TimerService.State.Running
        _tick.start()
    }

    function stop() {
        _tick.stop()
        state = TimerService.State.Idle
        remaining = 0
    }

    // ── Internal ──────────────────────────────────────────────────────────
    property real _lastTick: Date.now()   // timestamp of last tick for precision

    property var _tick: Timer {
        interval: 100
        repeat: true
        running: false
        onTriggered: {
            var now = Date.now()
            var elapsed = now - root._lastTick
            root._lastTick = now
            root.remaining = Math.max(0, root.remaining - elapsed)

            if (root.remaining <= 0 && root.extend > 0) {
                root.remaining = root.extend
                root.extend = 0
                root.extending = true
            } else if (root.remaining <= 0) {
                root._tick.stop()
                root.state = TimerService.State.Finished
            }
        }
    }

    function pad(n) { return n.toString().padStart(2, "0") }
}