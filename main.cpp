#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFileSystemModel>

#include <database.h>
#include <listmodel.h>
#include <sprintlistmodel.h>
#include <test.h>
#include <tutorials.h>
#include <drives.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Database db;
    db.connectToDatabase();  //connect to DB

    ListModel *model=new ListModel(&app);  //create listModel(without the pointer won't work)
    SprintListModel *sprintModel=new SprintListModel(&db,&app);
    //sprintModel->updateModel();


    Test *test=new Test(&app);
    Tutorials *tutorials=new Tutorials(&app);

    Drives *drives=new Drives();


    QQmlApplicationEngine engine;

    QQmlContext * context= engine.rootContext();
    context->setContextProperty("myModel",model);
    context->setContextProperty("database",&db);
    context->setContextProperty("sprintModel",sprintModel);
    context->setContextProperty("testInfo",test);
    context->setContextProperty("tutorials",tutorials);
    context->setContextProperty("myDrives",drives);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();

}
