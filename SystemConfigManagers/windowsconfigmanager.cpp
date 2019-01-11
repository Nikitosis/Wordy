#include "windowsconfigmanager.h"

WindowsConfigManager::WindowsConfigManager(QObject *parent) : ISystemConfigManager(parent)
{

}

QString WindowsConfigManager::getStoragePath()
{
    return QDir::currentPath();
}

void WindowsConfigManager::requestPermissions()
{

}
