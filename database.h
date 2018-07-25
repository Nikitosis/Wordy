#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QFile>
#include <QDate>
#include <QDebug>


#define DATABASE_HOSTNAME  "WordyDB"
#define DATABASE_NAME      "Wordy1.db"

#define TABLE_VOCABULARY        "Vocabulary"
#define VOCABULARY_WORD         "Word"
#define VOCABULARY_TRANSLATION  "Translation"
#define VOCABULARY_PACK         "Pack"
#define VOCABULARY_DATE         "Date"

#define TABLE_LEARNED             "Learned"
#define LEARNED_VOCABULARY_INDEX  "Vocabulary_Index"
#define LEARNED_DATE              "Date"


#ifdef myandroid                             //change paths according to our machine
    #define MYPATH QDir::currentPath()+"/db/"
#else
    #define MYPATH QDir::currentPath()+"/db/"
#endif

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
    bool insertIntoTableVocabulary(const QVariantList &data);
    bool insertIntoTableVocabulary(const QString &word, const QString &translation, int pack,const QDate date);
    bool removeRecordVocabulary(const int id);
    bool changeRecordVocabulary(const int id,const QVariantList &data);
    bool changeRecordVocabulary(const int id, const QString &word, const QString &translation, int pack,const QDate date);

    bool insertIntoTableLearned(const QVariantList &data);
    bool insertIntoTableLearned(const int vocabularyIndex,const QDate date);
    bool clearLearned();

    bool exportDatabase(const QString path, QString fileName);

    bool isFileExist(const QString path,QString fileName);

private:
    QSqlDatabase db;

private:
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();
};

#endif // DATABASE_H
