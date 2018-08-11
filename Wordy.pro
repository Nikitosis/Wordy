TEMPLATE = app

QT += qml quick
QT += sql
QT += widgets
CONFIG += c++11
CONFIG += resources_big

SOURCES += main.cpp \
    database.cpp \
    listmodel.cpp \
    sprintlistmodel.cpp \
    test.cpp \
    settingsmanager.cpp

RESOURCES += qml.qrc


android {
    database.files += mybase.sqlite
    database.path = assets/
    INSTALLS += database
}
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


android {
    database.files += Wordy.db
    database.path = assets/db
    INSTALLS += database
    DEFINES +=myandroid
    QT += androidextras
}

TRANSLATIONS+= Translation/Wordy_ru_RU.ts \
               Translation/Wordy_ua_UA.ts

HEADERS += \
    database.h \
    listmodel.h \
    sprintlistmodel.h \
    test.h \
    tutorials.h \
    settingsmanager.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    Wordy_en.ts

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
