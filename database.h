#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QFile>
#include <QDate>
#include <QDebug>


#define DATABASE_HOSTNAME  "WordyDB"
#define DATABASE_NAME      "Wordy.db"

#define TABLE_VOCABULARY        "Vocabulary"
#define VOCABULARY_WORD         "Word"
#define VOCABULARY_TRANSLATION  "Translation"

//first row is autoincrement


class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = nullptr);
    ~Database();

    void connectToDatabase();

signals:

public slots:
    bool insertIntoTable(const QVariantList &data);
    bool insertIntoTable(const QString &word, const QString &translation);
    bool removeRecord(const int id);

private:
    QSqlDatabase db;

private:
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();
};

#endif // DATABASE_H
