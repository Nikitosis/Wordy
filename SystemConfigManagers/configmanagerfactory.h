#ifndef CONFIGMANAGERFACTORY_H
#define CONFIGMANAGERFACTORY_H

#include "isystemconfigmanager.h"
#include "androidconfigmanager.h"
#include "windowsconfigmanager.h"

/*
 * Use this to create correct ConfigManager(whether it is Android/Windows config manager)
 */
class ConfigManagerFactory
{
public:
    static ISystemConfigManager *getConfigManager(QObject *parent=nullptr);
private:
    ConfigManagerFactory();
};

#endif // CONFIGMANAGERFACTORY_H
