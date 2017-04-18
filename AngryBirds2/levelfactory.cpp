#include <QCoreApplication>
#include <QDir>
#include "levelfactory.h"
#include <QDebug>

#define LEVEL_DIR_NAME "levels"
#define LEVEL_DIR qApp->applicationDirPath() + "/" LEVEL_DIR_NAME "/"

LevelFactory::LevelFactory(QObject *parent) : QObject(parent)
{
    QDir dir;
    dir.setCurrent(qApp->applicationDirPath());
    if(!dir.exists(LEVEL_DIR_NAME))
        dir.mkdir(LEVEL_DIR_NAME);
}

void LevelFactory::addLevel(QString name, QString jsonData)
{
    QFile file(LEVEL_DIR + name + ".level");
    if(!file.open(QIODevice::WriteOnly)){
        qWarning("Error saving level; %s", qPrintable(file.errorString()));
        return;
    }

    file.write(jsonData.toLocal8Bit());
    file.close();
}

QString LevelFactory::openLevel(QString name)
{
    if(name.startsWith(":"))
        name = name.remove(0, 1).prepend(":/levels/");
    else
        name = name.prepend(LEVEL_DIR);

    QFile file(name);
    if(!file.open(QIODevice::ReadOnly)){
        qWarning("Error loading level; %s", qPrintable(file.errorString()));
        return QString::null;
    }
    QByteArray buffer = file.readAll();
    file.close();
    return buffer;
}

QStringList LevelFactory::levels()
{
    QDir dir;
    QStringList levels;

    dir.cd(":/levels");
    QStringList qrcLevels = dir.entryList(QDir::Files);
    foreach (QString l, qrcLevels)
        levels.append(":" + l);

    dir.cd(LEVEL_DIR);
    levels.append(dir.entryList(QStringList() << "*.level", QDir::Files));

    return levels;
}
