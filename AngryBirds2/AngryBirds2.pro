QT += qml quick

CONFIG += c++11

SOURCES += main.cpp \
    levelfactory.cpp
HEADERS += \
    levelfactory.h

RESOURCES += qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
include(qml-box2d/box2d-static.pri)



