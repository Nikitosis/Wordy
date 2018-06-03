#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <database.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Database db;
    db.connectToDatabase();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
