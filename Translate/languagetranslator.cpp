#include "languagetranslator.h"

#include <QGuiApplication>
#include <QTranslator>
#include <QDebug>

LanguageTranslator::LanguageTranslator(QObject *parent) : QObject(parent),
    translator(nullptr), m_currentLanguage("en")
{
    translator = new QTranslator(this);
}

QString LanguageTranslator::p() const
{
    return m_p;
}

QString LanguageTranslator::currentLanguage() const
{
    return m_currentLanguage;
}

void LanguageTranslator::changeLanguage(QString language)
{
    if (translator)
        qApp->removeTranslator(translator);

    if (translator->load(":/translations/sample." + language.toLower()))
    {
        bool b = qApp->installTranslator(translator);
        qDebug() << "Install translate:" << language << b;

        if (b) {
//            setCurrentLanguage(language);
            emit pChanged(QString());
        }
    }
    else
    {
        qDebug() << "Unable to load translation" << language;
    }
}

void LanguageTranslator::setP(QString p)
{
    if (m_p == p)
        return;

    m_p = p;
    emit pChanged(m_p);
}

void LanguageTranslator::setCurrentLanguage(QString currentLanguage)
{
    qDebug() << "setCurrentLanguage" << m_currentLanguage << currentLanguage;
    if (m_currentLanguage == currentLanguage)
        return;

    changeLanguage(currentLanguage);
    m_currentLanguage = currentLanguage;
    emit currentLanguageChanged(m_currentLanguage);
}
