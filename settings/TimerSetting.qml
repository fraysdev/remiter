pragma Singleton

import QtCore

Settings {
    category: "Timer"
    property string presets: "[]"

    property var presetsRaw: JSON.parse(presets)

    function addPreset(preset) {
        const updated = presetsRaw.concat([preset])
        _save(updated)
        console.error(presets)
    }

    function removePreset(index) {
        const updated = presetsRaw.filter((_, i) => i !== index)
        _save(updated)
    }

    function updatePreset(index, preset) {
        const updated = presetsRaw.map((p, i) => i === index ? preset : p)
        _save(updated)
    }

    function forceRestart() {
        _save([])
        console.log("Presets: " + presets)
    }

    function _save(updatedPresets) {
        presetsRaw = updatedPresets
        presets = JSON.stringify(updatedPresets)
    }
}
