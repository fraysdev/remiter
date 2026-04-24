pragma Singleton
import QtQuick

QtObject {
    id: root

    enum State {
        Idle,
        Running,
        Paused
    }

    property int state: StopwatchService.State.Idle
    property int elapsed: 0
    property var laps: []

    readonly property string display: {
        let cs = Math.floor(elapsed / 10) % 100
        let s  = Math.floor(elapsed / 1000) % 60
        let m  = Math.floor(elapsed / 60000) % 60
        let h  = Math.floor(elapsed / 3600000)

        if (h > 0)
            return pad(h) + ":" + pad(m) + ":" + pad(s)
        return pad(m) + ":" + pad(s) + "." + pad(cs)
    }

    function start() {
        _lastTick = Date.now()
        state = StopwatchService.State.Running
        _tick.start()
    }

    function pause() {
        _tick.stop()
        state = StopwatchService.State.Paused
    }

    function resume() {
        _lastTick = Date.now()
        state = StopwatchService.State.Running
        _tick.start()
    }

    function toggleRunning() {
        if (state === StopwatchService.State.Running) pause()
        else if (state === StopwatchService.State.Paused) resume()
    }

    function stop() {
        _tick.stop()
        state = StopwatchService.State.Idle
        elapsed = 0
        laps = []
    }

    function lap() {
        if (state === StopwatchService.State.Idle) return;
        var lastLapMs = laps.length > 0 ? laps[laps.length - 1].total : 0;
        console.log("laps.length:", laps.length)
        console.log("lastLapMs:", lastLapMs)
        console.log("elapsed:", elapsed, formatTime(elapsed))
        console.log("lap:", elapsed - lastLapMs, formatTime(elapsed - lastLapMs))

        laps = laps.concat([{
            "number": laps.length + 1,
            "lap": elapsed - lastLapMs,
            "total": elapsed,
            "lapFormat": formatTime(elapsed - lastLapMs),
            "totalFormat": formatTime(elapsed),
        }]);
    }

    function getLastLap() {
        return laps[laps.length - 1];
    }

    property real _lastTick: 0

    property var _tick: Timer {
        interval: 10
        repeat: true
        running: false
        onTriggered: {
            let now = Date.now()
            root.elapsed += now - root._lastTick
            root._lastTick = now
        }
    }

    function formatTime(time) {
        let cs = Math.floor(time / 10) % 100
        let s  = Math.floor(time / 1000) % 60
        let m  = Math.floor(time / 60000) % 60
        let h  = Math.floor(time / 3600000)

        if (h > 0)
            return pad(h) + ":" + pad(m) + ":" + pad(s)
        return pad(m) + ":" + pad(s) + "." + pad(cs)
    }

    function pad(n) { return n.toString().padStart(2, "0") }
}