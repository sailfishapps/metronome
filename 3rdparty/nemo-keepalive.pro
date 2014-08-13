TEMPLATE = lib
TARGET = keepaliveplugin
TARGET = $$qtLibraryTarget($$TARGET)
QT += dbus qml
CONFIG += debug plugin
INCLUDEPATH += nemo-keepalive/lib
 
PROJECT = metronome
TARGET_PATH = /usr/share/harbour-$$PROJECT/harbour/$$PROJECT/keepalive
 
system(qdbusxml2cpp -p nemo-keepalive/lib/mceiface.h:nemo-keepalive/lib/mceiface.cpp nemo-keepalive/lib/mceiface.xml)
 
# workaround to allow custom import paths
system(sed -e s/org\.nemomobile\.keepalive/harbour.metronome.keepalive/ -e s/plugin\.moc/plugin-fixed.moc/ nemo-keepalive/plugin/plugin.cpp > nemo-keepalive/plugin/plugin-fixed.cpp)
 
SOURCES += \
$$PWD/libiphb/src/libiphb.c \
$$PWD/nemo-keepalive/lib/displayblanking.cpp \
$$PWD/nemo-keepalive/lib/displayblanking_p.cpp \
$$PWD/nemo-keepalive/lib/backgroundactivity.cpp \
$$PWD/nemo-keepalive/lib/backgroundactivity_p.cpp \
$$PWD/nemo-keepalive/lib/mceiface.cpp \
$$PWD/nemo-keepalive/lib/heartbeat.cpp \
$$PWD/nemo-keepalive/plugin/declarativebackgroundactivity.cpp \
$$PWD/nemo-keepalive/plugin/plugin-fixed.cpp
 
HEADERS += \
$$PWD/libiphb/src/libiphb.h \
$$PWD/libiphb/src/iphb_internal.h \
$$PWD/nemo-keepalive/lib/displayblanking.h \
$$PWD/nemo-keepalive/lib/displayblanking_p.h \
$$PWD/nemo-keepalive/lib/backgroundactivity.h \
$$PWD/nemo-keepalive/lib/backgroundactivity_p.h \
$$PWD/nemo-keepalive/lib/mceiface.h \
$$PWD/nemo-keepalive/lib/heartbeat.h \
$$PWD/nemo-keepalive/lib/common.h \
$$PWD/nemo-keepalive/plugin/declarativebackgroundactivity.h
 
target.path = $$TARGET_PATH
qmldir.path = $$TARGET_PATH
qmldir.files = qmldir
INSTALLS += target qmldir
