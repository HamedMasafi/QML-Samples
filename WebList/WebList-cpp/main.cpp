#include <QtCore/qglobal.h>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include "webrequest.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<WebRequest>("Tooska.qml.samples", 1, 0, "WebRequest");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
