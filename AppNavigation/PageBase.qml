import QtQuick 2.0
import QtQuick.Controls 2.0

Page {

    signal openPage(string page);
    signal openPageWithArgs(string page, variant properties);

    clip: true
}

