#ifndef WEBREQUEST_H
#define WEBREQUEST_H

#include <QUrl>
#include <QtCore/QObject>
#include <QtCore/qglobal.h>

class QNetworkAccessManager;
class QNetworkReply;
class WebRequest : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isLoading READ isLoading WRITE setIsLoading NOTIFY isLoadingChanged)

    QNetworkAccessManager *manager;
    bool m_isLoading;

public:
    explicit WebRequest(QObject *parent = 0);


bool isLoading() const
;

signals:
    void dataRecived(QString data);
    void isLoadingChanged(bool isLoading);

private slots:
    void finished(QNetworkReply *reply);

public slots:
    void get(QUrl url);
    void setIsLoading(bool isLoading);
};

#endif // WEBREQUEST_H
