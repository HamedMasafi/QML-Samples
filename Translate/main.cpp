#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "languagetranslator.h"

static QObject* create_singelton_object_LanguageTranslator(QQmlEngine *, QJSEngine *)
{
    return new LanguageTranslator();
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterSingletonType<LanguageTranslator>("Hamed", 1, 0,
                                                 "LanguageTranslator",
                                                 create_singelton_object_LanguageTranslator);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
