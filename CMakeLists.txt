cmake_minimum_required(VERSION 3.16)

project(remiter VERSION 0.1.2 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(qml_singletons
    Style.qml
    services/ClockService.qml
    services/TimerService.qml
    settings/TimerSetting.qml
)

find_package(Qt6 REQUIRED COMPONENTS Quick Svg)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appremiter
    main.cpp
)

set_source_files_properties(${qml_singletons}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(appremiter
    URI remiter
    QML_FILES
        Main.qml
        commons/CButton.qml
        commons/CButtonless.qml
        commons/CText.qml
        commons/CTextField.qml
        commons/SvgIcon.qml
        components/controls/TimerControl.qml
        components/presets/TimerPreset.qml
        components/Titlebar.qml
        windows/PopupTime.qml
        ${qml_singletons}
    RESOURCES
        assets/fonts/Sen.ttf
        assets/fonts/InputMono-Black.ttf
        assets/fonts/InputMono-Bold.ttf
        assets/fonts/InputMono-Medium.ttf
        assets/fonts/InputMono-Regular.ttf
        assets/fonts/InputMono-Thin.ttf
        assets/fonts/InputMono-Light.ttf
        assets/fonts/InputMono-ExtraLight.ttf
        assets/icons/controls/play.svg
        assets/icons/controls/pause.svg
        assets/icons/controls/stop.svg
        assets/icons/controls/restart.svg
        assets/icons/modules/clock.svg
        assets/icons/modules/timer.svg
        assets/icons/modules/stopwatch.svg
        assets/icons/modules/stopwatch/lap.svg
        assets/icons/presets/add.svg
        assets/icons/presets/edit.svg
        assets/icons/presets/save.svg
        assets/icons/presets/delete.svg
        assets/icons/presets/delete_all.svg
        assets/icons/windows/show.svg
        assets/icons/windows/lock.svg
        assets/icons/windows/unlock.svg
        assets/icons/windows/close.svg
        assets/icons/windows/minimize.svg
        assets/icons/left.svg
        assets/icons/right.svg
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appremiter PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appremiter
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appremiter
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Svg
)

install(TARGETS appremiter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
