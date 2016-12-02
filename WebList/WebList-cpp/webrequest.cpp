#include "webrequest.h"

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QDebug>

WebRequest::WebRequest(QObject *parent) : QObject(parent), m_isLoading(false)
{
    manager = new QNetworkAccessManager();
    connect(manager, &QNetworkAccessManager::finished, this, &WebRequest::finished);
}

bool WebRequest::isLoading() const
{
    return m_isLoading;
}

void WebRequest::finished(QNetworkReply *reply)
{
    emit dataRecived(reply->readAll());
    setIsLoading(false);
}

void WebRequest::get(QUrl url)
{
    setIsLoading(true);
    QNetworkRequest request;
    request.setUrl(url);

    manager->get(request);
}

void WebRequest::setIsLoading(bool isLoading)
{
    if (m_isLoading == isLoading)
        return;

    m_isLoading = isLoading;
    emit isLoadingChanged(isLoading);
}
