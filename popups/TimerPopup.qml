import QtQuick
import QtQuick.Layouts

import "../commons"

PopupLayout {
    id: root
    name: "Timer"
    iconSource: "modules/timer.svg"
    timeDisplay: TimerService.state !== TimerService.State.Idle ? TimerService.display : ""
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
