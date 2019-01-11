#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFileSystemModel>
#include <QTranslator>
#include <QLocale>

#include "SystemConfigManagers/isystemconfigmanager.h"
#include "SystemConfigManagers/configmanagerfactory.h"

#ifdef myandroid
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>
#endif

#include <database.h>
#include <listmodel.h>
#include <sprintlistmodel.h>
#include <test.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //install Translation

    QTranslator translator;
    translator.load(":/Translation/Wordy_"+QLocale::system().name()+".qm");

    app.installTranslator(&translator);
    qDebug()<<"Language: "<<QLocale::system().name();



    Database db;
    db.connectToDatabase();  //connect to DB

    ListModel *vocabularyModel=new ListModel(&app);  //create models(without the pointer won't work)
    SprintListModel *sprintModel=new SprintListModel(&db,&app);

    Test *test=new Test(&app);                       //create test backend

    ISystemConfigManager *configManager=ConfigManagerFactory::getConfigManager();   //to control permissions and get storagePath
    configManager->requestPermissions();  //toDo: ask for permission only when import/export buttons are clicked

    QQmlApplicationEngine engine;

    QQmlContext * context= engine.rootContext();
    context->setContextProperty("vocabularyModel",vocabularyModel);
    context->setContextProperty("database",&db);
    context->setContextProperty("sprintModel",sprintModel);
    context->setContextProperty("testInfo",test);
    context->setContextProperty("settingsManager",&SettingsManager::getInstance());
    context->setContextProperty("configManager",configManager);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;



    return app.exec();

}
