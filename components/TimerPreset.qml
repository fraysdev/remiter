import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../commons"

Item {
    id: root

    // ── Public API ────────────────────────────────────────────────────────
    signal presetSelected(var preset)

    // ── Internal ──────────────────────────────────────────────────────────
    implicitWidth: layout.implicitWidth

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: 0

        // Header row: title + action buttons
        RowLayout {
            Layout.fillWidth: true

            Label {
                text: "Timer Preset"
                Layout.fillWidth: true
            }

            Button {
                text: "Remove"
                enabled: presetList.currentIndex >= 0
                onClicked: {
                    if (presetList.currentIndex >= 0)
                        presetModel.remove(presetList.currentIndex)
                }
            }

            Button {
                text: "Edit"
                enabled: presetList.currentIndex >= 0
                onClicked: console.log("Edit preset", presetList.currentIndex)
            }

            Button {
                text: "Add"
                onClicked: {
                    presetModel.append({
                        "name": "New Preset",
                        "duration": "00:00:00",
                        "adjustment": ""
                    })
                }
            }
        }

        // Preset list
        ListView {
            id: presetList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            currentIndex: -1

            model: ListModel {
                id: presetModel
            }

            delegate: ItemDelegate {
                width: presetList.width
                highlighted: ListView.isCurrentItem

                onClicked: {
                    presetList.currentIndex = index
                    root.presetSelected(model)
                }

                RowLayout {
                    anchors.fill: parent

                    Label {
                        text: model.name
                        Layout.fillWidth: true
                    }

                    ColumnLayout {
                        spacing: 0

                        Label {
                            text: model.duration
                        }

                        Label {
                            text: model.adjustment
                            visible: model.adjustment !== ""
                        }
                    }
                }
            }
        }
    }
}
