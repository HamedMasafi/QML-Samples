#ifndef LANGUAGETRANSLATOR_H
#define LANGUAGETRANSLATOR_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>

class QTranslator;
class LanguageTranslator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString p READ p WRITE setP NOTIFY pChanged)
    Q_PROPERTY(QString currentLanguage READ currentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    QTranslator *translator;
    
    QString m_p;

    QString m_currentLanguage;
    void changeLanguage(QString language);

public:
    explicit LanguageTranslator(QObject *parent = nullptr);

    QString p() const;

    QString currentLanguage() const;

signals:

    void pChanged(QString p);

    void currentLanguageChanged(QString currentLanguage);

public slots:
    void setP(QString p);
    void setCurrentLanguage(QString currentLanguage);
};

#endif // LANGUAGETRANSLATOR_H
