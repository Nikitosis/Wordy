#include "androidconfigmanager.h"
#ifdef Q_OS_ANDROID

#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#include <QtAndroid>


AndroidConfigManager::AndroidConfigManager(QObject *parent) : ISystemConfigManager(parent)
{

}

void AndroidConfigManager::requestStoragePermissions()
{
    qDebug()<<"ReguestStoragePermission";
    const QVector<QString> permissions({"android.permission.WRITE_EXTERNAL_STORAGE",
                                        "android.permission.READ_EXTERNAL_STORAGE"});

    for(QString curPermission:permissions)
    {
        auto  result = QtAndroid::checkPermission(curPermission);
        if(result == QtAndroid::PermissionResult::Denied)
            QtAndroid::PermissionResultMap resultHash = QtAndroid::requestPermissionsSync(QStringList({curPermission}));
    }
}

QString AndroidConfigManager::getStoragePath()
{
    //QAndroidJniObject gives us ability to call java functions
    //call getExternalStorageDirectory() function,that returns File
    QAndroidJniObject mediaDir = QAndroidJniObject::callStaticObjectMethod("android/os/Environment", "getExternalStorageDirectory", "()Ljava/io/File;");
    //call this File's method getAbsolutePath()
    QAndroidJniObject mediaPath = mediaDir.callObjectMethod( "getAbsolutePath", "()Ljava/lang/String;" );

    QString storagePath = mediaPath.toString();

    QAndroidJniEnvironment env;
    if (env->ExceptionCheck()) {
            // Handle exception here.
            env->ExceptionClear();
    }

    storagePath="file://"+storagePath;  //to work with FolderListModel(QML)
    return storagePath;
}

void AndroidConfigManager::requestPermissions()
{
    requestStoragePermissions();
}

#endif
