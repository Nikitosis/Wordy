#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QFile>
#include <QDate>
#include <QDebug>
#include <QStandardPaths>


#define DATABASE_HOSTNAME  "WordyDB"
#define DATABASE_NAME      "Wordy.db"

#define TABLE_VOCABULARY        "Vocabulary"
#define VOCABULARY_WORD         "Word"
#define VOCABULARY_TRANSLATION  "Translation"
#define VOCABULARY_PACK         "Pack"
#define VOCABULARY_DATE         "Date"

#define TABLE_LEARNED             "Learned"
#define LEARNED_VOCABULARY_INDEX  "Vocabulary_Index"
#define LEARNED_DATE              "Date"

#define FINAL_DATABASE_VERSION  1


#ifdef myandroid                             //change paths according to our machine
    #define MYPATH QStandardPaths::writableLocation(QStandardPaths::AppDataLocation)+"/db/"
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



signals:

public slots:
    bool connectToDatabase();

    bool insertIntoTableVocabulary(const QVariantList &data);
    bool insertIntoTableVocabulary(const QString &word, const QString &translation, int pack,const QDate date);
    bool removeRecordVocabulary(const int id);
    bool changeRecordVocabulary(const int id,const QVariantList &data);
    bool changeRecordVocabulary(const int id, const QString &word, const QString &translation, int pack,const QDate date);

    bool insertIntoTableLearned(const QVariantList &data);
    bool insertIntoTableLearned(const int vocabularyIndex,const QDate date);
    bool clearLearned();

    bool exportDatabase(const QString path, QString fileName);
    bool importDatabase(const QString path);

    int getWordPack(int id);
    QDate getWordDate(int id);

    bool isFileExist(const QString path,QString fileName);

private:
    QSqlDatabase db;

protected:
    bool openDataBase();
    bool restoreDataBase();
    void closeDataBase();
    bool createTable();

    bool setDatabaseVersion(int version);
    int  getDatabaseVersion();
    void updateDatabaseVersion();
};

#endif // DATABASE_H
