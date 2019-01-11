#include "configmanagerfactory.h"

ISystemConfigManager *ConfigManagerFactory::getConfigManager(QObject *parent)
{
#ifdef Q_OS_ANDROID
    return new AndroidConfigManager(parent);
#endif
#ifdef Q_OS_WIN
    return new WindowsConfigManager(parent);
#endif
}

ConfigManagerFactory::ConfigManagerFactory()
{

}
