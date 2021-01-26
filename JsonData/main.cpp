#include <QFile>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QFile jsonFile(":/sample.json");
    jsonFile.open(QIODevice::ReadOnly | QIODevice::Text);
    QByteArray json = jsonFile.readAll();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("JsonData", json);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
