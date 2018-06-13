#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <database.h>
#include <listmodel.h>
#include <sprintlistmodel.h>
#include <test.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Database db;
    db.connectToDatabase();  //connect to DB

    ListModel *model=new ListModel();  //create listModel(without the pointer won't work)
    SprintListModel *sprintModel=new SprintListModel(&db);
    //sprintModel->updateModel();


    Test test;

    QQmlApplicationEngine engine;

    QQmlContext * context= engine.rootContext();
    context->setContextProperty("myModel",model);
    context->setContextProperty("database",&db);
    context->setContextProperty("sprintModel",sprintModel);
    context->setContextProperty("testInfo",&test);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
