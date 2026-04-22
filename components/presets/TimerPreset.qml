import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../../commons"

Item {
    id: root

    required property var nameTimerInput
    required property var mainTimerInput
    required property var extendTimerInput

    property bool isEditing: false
    property int editIndex: -1

    Rectangle {
        color: "#303030"
        anchors.fill: root
        radius: 4

        ColumnLayout {
            id: timerPresetLayout
            anchors.fill: parent
            spacing: 0

            RowLayout {
                Layout.fillWidth: true
                Layout.margins: 8

                CText {
                    text: "Timer Preset"
                    font.pixelSize: 16
                    font.weight: 700
                }

                Item { Layout.fillWidth: true }

                CButton {
                    iconSource: "presets/delete_all.svg"
                    text: "Delete All"
                    onClicked: TimerSetting.forceRestart()
                }

                CButton {
                    visible: !root.isEditing
                    iconSource: "presets/add.svg"
                    text: "Add"
                    onClicked: TimerSetting.addPreset({
                        "name": nameTimerInput.text,
                        "duration": mainTimerInput.text,
                        "extend": extendTimerInput.text,
                    })
                }

                CButton {
                    visible: root.isEditing
                    iconSource: "presets/save.svg"
                    text: "Save"
                    onClicked: {
                        TimerSetting.updatePreset(root.editIndex, {
                            "name": nameTimerInput.text,
                            "duration": mainTimerInput.text,
                            "extend": extendTimerInput.text,
                        });

                        root.isEditing = false
                        root.editIndex = -1
                    }
                }
            }

            ListView {
                id: presetList
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                currentIndex: -1

                model: ListModel {
                    id: presetModel
                }

                Connections {
                    target: TimerSetting
                    function onPresetsRawChanged() { presetList.syncModel() }
                }

                Component.onCompleted: syncModel()

                function syncModel() {
                    presetModel.clear()
                    TimerSetting.presetsRaw.forEach(p => presetModel.append(p))
                }

                delegate: Rectangle {
                    width: presetList.width
                    height: presetInfo.implicitHeight + 16
                    color: model.index % 2 === 0 ? "#404040" : "#484848"

                    HoverHandler {
                        id: presetHoverHandler
                    }

                    ColumnLayout {
                        id: presetInfo
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 8
                        spacing: 0

                        CText {
                            text: model.name
                            font.pixelSize: 16
                        }

                        RowLayout {
                            spacing: 4

                            CText {
                                text: model.duration
                                font.family: Style.timeFont
                                font.weight: 600
                                font.pixelSize: 14
                            }

                            CText {
                                visible: model.extend !== "+00:00:00"
                                text: model.extend
                                font.family: Style.timeFont
                                font.weight: 600
                                font.pixelSize: 10
                            }
                        }
                    }

                    RowLayout {
                        id: presetActionButton
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 8
                        visible: presetHoverHandler.hovered
                        spacing: 0

                        CButtonless {
                            iconSource: "presets/delete.svg"
                            onClicked: TimerSetting.removePreset(model.index)
                        }

                        CButtonless {
                            iconSource: "presets/edit.svg"
                            onClicked: {
                                nameTimerInput.text = model.name
                                mainTimerInput.text = model.duration
                                extendTimerInput.text = model.extend

                                root.isEditing = true
                                root.editIndex = model.index
                            }
                        }
                    }
                }
            }
        }
    }
}
