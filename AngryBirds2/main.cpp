#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <box2dplugin.h>

#include "levelfactory.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<LevelFactory>("Tooska", 1, 0, "LevelFactory");

    Box2DPlugin plugin;
    plugin.registerTypes("Box2D");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
