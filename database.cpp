#include "database.h"

Database::Database(QObject *parent) : QObject(parent)
{

}

Database::~Database()
{
    closeDataBase();
}

void Database::connectToDatabase()
{

    #ifndef myandroid
        qDebug()<<"USING DESKTOP";
    #else
         qDebug()<<"USING ANDROID";
    #endif

    this->restoreDataBase();
    /*if(!QFile(MYPATH DATABASE_NAME).exists())   //if doesn't exist
        this->restoreDataBase();    //create new db
    else
    {
        QFile(MYPATH DATABASE_NAME).copy("./" DATABASE_NAME);
        QFile::setPermissions("./" DATABASE_NAME,QFile::WriteOwner |     QFile::ReadOwner);
        this->openDataBase();       //open existing
    }*/
}

bool Database::insertIntoTable(const QVariantList &data)
{
    QSqlQuery query;

    query.prepare("INSERT INTO " TABLE_VOCABULARY " ( "
                                                    VOCABULARY_WORD         ", "
                                                    VOCABULARY_TRANSLATION  ", "
                                                    VOCABULARY_PACK         ", "
                                                    VOCABULARY_DATE         ") "
                    "VALUES (:Word, :Translation, :Pack, :Date)"
                  );
    query.bindValue(":Word",data[0].toString());
    query.bindValue(":Translation",data[1].toString());
    query.bindValue(":Pack",data[2].toInt());
    query.bindValue(":Date",data[3].toDate());

    if(!query.exec())
    {
        qDebug() <<"error inserting into" <<TABLE_VOCABULARY;
        qDebug() <<query.lastError().text();
        return false;
    }

    return true;

}

bool Database::insertIntoTable(const QString &word, const QString &translation, int pack, const QDate date)
{
   QVariantList list;
   list<<word<<translation<<pack<<date;

   return insertIntoTable(list);
}

bool Database::removeRecord(const int id)
{
    QSqlQuery query;

    query.prepare("DELETE FROM " TABLE_VOCABULARY " WHERE id= :ID ;");
    query.bindValue(":ID",id);

    if(!query.exec())
        {
            qDebug() <<"error deleting row"<<id;
            qDebug() <<query.lastError().text();
            return false;
        }
    return true;
}

bool Database::changeRecord(const int id, const QVariantList &data)
{
    QSqlQuery query;

    query.prepare("UPDATE "TABLE_VOCABULARY " SET Word= :WORD , Translation= :TRANSLATION , Pack= :PACK, Date= :DATE WHERE id= :ID ;");


    query.bindValue(":WORD",data[0].toString());
    query.bindValue(":TRANSLATION",data[1].toString());
    query.bindValue(":PACK",data[2].toInt());
    query.bindValue(":DATE",data[3].toDate());
    query.bindValue(":ID",id);

    if(!query.exec())
    {
        qDebug() <<"error modifying row";
        qDebug() <<query.lastError().text();
        return false;
    }
    qDebug()<<"UPDATED: "<<data[0].toString()<<data[1].toString()<<id;
    return true;
}

bool Database::changeRecord(const int id, const QString &word, const QString &translation, int pack, const QDate date)
{
    QVariantList list;
    list<<word<<translation<<pack<<date;

    return changeRecord(id,list);
}

bool Database::openDataBase()
{
    db=QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName("./" DATABASE_NAME);

    if(db.open())
        return true;

    return false;
}

bool Database::restoreDataBase()
{
    if(this->openDataBase())
        return this->createTable() ? true : false;    //if we created db,we create table
    else
    {
        qDebug()<< "Failed to restore DataBase";
        return false;
    }
    return false;
}

void Database::closeDataBase()
{
    db.close();
}

bool Database::createTable()
{
    QSqlQuery query;

    query.prepare("CREATE TABLE " TABLE_VOCABULARY " ("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    VOCABULARY_WORD         " VARCHAR(40) NOT NULL, "
                    VOCABULARY_TRANSLATION  " VARCHAR(40) NOT NULL, "
                    VOCABULARY_PACK         " INT NOT NULL, "
                    VOCABULARY_DATE         " DATE "
                    " )"
                  );
    if(query.exec())
        return true;
    return false;
}
