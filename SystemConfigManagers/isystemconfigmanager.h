#ifndef ISYSTEMCONFIGMANAGER_H
#define ISYSTEMCONFIGMANAGER_H

#include <QObject>

/*
 * Handles system specific configurations
 */
class ISystemConfigManager:public QObject
{
    Q_OBJECT
public:
    ISystemConfigManager(QObject *parent=nullptr);

    Q_INVOKABLE virtual QString getStoragePath()=0;   //Returns storage path.this function can be called from QML
public slots:
    virtual void requestPermissions()=0;
};

#endif // ISYSTEMCONFIGMANAGER_H
