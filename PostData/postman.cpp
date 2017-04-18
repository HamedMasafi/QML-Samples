#include "postman.h"

#include <QFile>
#include <QFileInfo>
#include <QtNetwork>
#include <QTextStream>

Postman::Postman(QObject *parent) : QObject(parent)
{
    net.setObjectName("net");
    net.setParent(this);
    QMetaObject::connectSlotsByName(this);
}

void Postman::on_net_finished(QNetworkReply *reply)
{
    emit finished(QString(reply->readAll()));
}

void Postman::sendFile(QString filePath)
{
    QFileInfo info(filePath);

    const QUrl url("http://pachenar.ir/upload/file.php");

    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    QHttpPart imagePart;
    imagePart.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("image/" + info.suffix()));
    imagePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"photo\"; filename=\"" + info.fileName() + "\""));
    QFile *file = new QFile(filePath);
    file->open(QIODevice::ReadOnly);
    imagePart.setBodyDevice(file);
    file->setParent(multiPart);

    multiPart->append(imagePart);

    QNetworkRequest request(url);
    net.post(request, multiPart);
}
