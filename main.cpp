#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFileSystemModel>
#include <QTranslator>
#include <QLocale>

#ifdef myandroid
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>
#endif

#include <database.h>
#include <listmodel.h>
#include <sprintlistmodel.h>
#include <test.h>
#include <tutorials.h>

//QAndroidJniObject gives us ability to call java functions
QString getStoragePath()
{
#ifdef myandroid
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
#else
    return QDir::currentPath();
#endif
}

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
    Tutorials *tutorials=new Tutorials(&app);

    QString storagePath=getStoragePath();


    QQmlApplicationEngine engine;

    QQmlContext * context= engine.rootContext();
    context->setContextProperty("vocabularyModel",vocabularyModel);
    context->setContextProperty("database",&db);
    context->setContextProperty("sprintModel",sprintModel);
    context->setContextProperty("testInfo",test);
    context->setContextProperty("tutorials",tutorials);
    context->setContextProperty("storagePath",QVariant::fromValue(storagePath));

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;



    return app.exec();

}
