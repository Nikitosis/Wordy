#ifndef WINDOWSCONFIGMANAGER_H
#define WINDOWSCONFIGMANAGER_H

#include <QObject>
#include <QDir>

#include "isystemconfigmanager.h"

/*
 * Handles config in Windows system(storage path)
 */
class WindowsConfigManager : public ISystemConfigManager
{
    Q_OBJECT
public:
    explicit WindowsConfigManager(QObject *parent = nullptr);

    Q_INVOKABLE QString getStoragePath() override; //Returns storage path.this function can be called from QML

public slots:
    void requestPermissions() override;


signals:

public slots:
};

#endif // WINDOWSCONFIGMANAGER_H
