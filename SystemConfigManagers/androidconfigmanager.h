#ifndef ANDROIDCONFIGMANAGER_H
#define ANDROIDCONFIGMANAGER_H

#include <QObject>
#include <QVector>
#include <QDebug>

#include "isystemconfigmanager.h"

/*
 * Handles config in Android system(permission management and storage path)
 */
class AndroidConfigManager :public ISystemConfigManager
{
    Q_OBJECT
public:
    explicit AndroidConfigManager(QObject *parent = nullptr);

    Q_INVOKABLE QString getStoragePath() override; //Returns storage path.this function can be called from QML

public slots:
    void requestPermissions() override;

private:
    void requestStoragePermissions();


signals:

public slots:


};

#endif // ANDROIDCONFIGMANAGER_H
