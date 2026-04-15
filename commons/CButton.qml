import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.VectorImage

Button {
    id: control

    // property item icon
    property string iconSource: ""
    property int iconSize: 18

    background: Rectangle {
        color: "#3C3C3C"
        radius: 5
        border.color: control.down ? "#C0888888" :"#888888"
        border.width: 1
    }

    contentItem: RowLayout {
        spacing: 2

        SvgIcon {
            source: control.iconSource
            size: control.iconSize
            color: control.down ? "#C0FFFFFF" : "#FFFFFF"
        }

        CText {
            text: control.text
            color: control.down ? "#C0FFFFFF" : "#FFFFFF"
            visible: control.text
            font.family: Style.textFont
        }
    }
}
