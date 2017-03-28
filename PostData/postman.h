#ifndef POSTMAN_H
#define POSTMAN_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>

#include <QNetworkAccessManager>
#include <QNetworkReply>

class Postman : public QObject
{
    Q_OBJECT
    QNetworkAccessManager net;

public:
    explicit Postman(QObject *parent = 0);

signals:
    void finished(QString data);

private slots:
    void on_net_finished(QNetworkReply *reply);

public slots:
    void sendFile(QString filePath);
};

#endif // POSTMAN_H
