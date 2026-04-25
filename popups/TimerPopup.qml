import QtQuick
import QtQuick.Layouts

import "../commons"

PopupLayout {
    id: root
    name: "Timer"
    iconSource: "modules/timer.svg"
    timeDisplay: TimerService.state !== TimerService.State.Idle ? TimerService.display : ""
    timeColor: {
        if (TimerService.state === TimerService.State.Idle)
            return Style.textColor

        let color = Style.textColorRunning
        if (TimerService.extending) color = Style.textColorExtend

        let seconds = Math.floor(TimerService.remaining / 1000)
        if (seconds <= 60 && seconds % 2 === 0) color = Style.textColorFinish

        if (TimerService.state === TimerService.State.Paused)
            color = Qt.tint(color, "#60202020")

        return color
    }
    status: {
        if (TimerService.state === TimerService.State.Running && TimerService.extending)
            return "Extending"
        else if (TimerService.state === TimerService.State.Paused)
            return "Paused"
        else if (TimerService.state === TimerService.State.Finished)
            return "Finished"
        return ""
    }
}
