#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("FraysDev");
    app.setOrganizationDomain("dev.frays");
    app.setApplicationName("Remiter");

    QQuickStyle::setStyle("Fusion");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("remiter", "Main");

    return QCoreApplication::exec();
}
