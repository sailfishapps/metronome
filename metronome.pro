# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
QT += multimedia dbus

TARGET = harbour-metronome

CONFIG += sailfishapp

PKGCONFIG += keepalive

SOURCES += src/harbour-metronome.cpp \
    src/piecircle.cpp

OTHER_FILES += qml/harbour-metronome.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SettingsPage.qml \
    qml/components/LocalStorage.qml \
    rpm/harbour-metronome.spec \
    rpm/harbour-metronome.yaml \
    harbour-metronome.desktop

RESOURCES += \
    resources.qrc

HEADERS += \
    src/piecircle.h

