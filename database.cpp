#include "database.h"

Database::Database(QObject *parent) : QObject(parent)
{

}

Database::~Database()
{
    closeDataBase();
}


bool Database::connectToDatabase()
{

    #ifndef myandroid
        qDebug()<<"USING DESKTOP";
    #else
         qDebug()<<"USING ANDROID";
    #endif


    //this->restoreDataBase();
    //QFile file(MYPATH DATABASE_NAME);
    //file.remove();
    if(!QDir(MYPATH).exists())
        QDir().mkdir(MYPATH);

    qDebug()<<"Database: "+MYPATH DATABASE_NAME;

    bool noError=true;


    if(!QFile(MYPATH DATABASE_NAME).exists())   //if doesn't exist
        noError= this->restoreDataBase();    //create new db
    else
    {
        //QFile(MYPATH DATABASE_NAME).copy("./" DATABASE_NAME);
        //QFile::setPermissions("./" DATABASE_NAME,QFile::WriteOwner |     QFile::ReadOwner);
        noError= this->openDataBase();       //open existing
    }

    if(noError)
        updateDatabaseVersion();

    return noError;
}

//implement database migration
//for each new database version,create new resource txt file,which represent queries for transition from previous to current version of db
//loop through these files and run queries
//If FINAL_DATABASE_VERSION=5, but getDatabaseVersion=2, it updates v.2->v.3->v.4->v.5
void Database::updateDatabaseVersion()
{
    qDebug()<<"Database Version="<< getDatabaseVersion();
    if(getDatabaseVersion()!=FINAL_DATABASE_VERSION)
    {
            //...
    }

    setDatabaseVersion(FINAL_DATABASE_VERSION);
}

bool Database::insertIntoTableVocabulary(const QVariantList &data)
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

bool Database::insertIntoTableVocabulary(const QString &word, const QString &translation, int pack, const QDate date)
{
   QVariantList list;
   list<<word<<translation<<pack<<date;

   return insertIntoTableVocabulary(list);
}

bool Database::removeRecordVocabulary(const int id)
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

bool Database::changeRecordVocabulary(const int id, const QVariantList &data)
{
    QSqlQuery query;

    query.prepare("UPDATE " TABLE_VOCABULARY " SET Word= :WORD , Translation= :TRANSLATION , Pack= :PACK, Date= :DATE WHERE id= :ID ;");


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
    qDebug()<<"UPDATED: "<<data[0].toString()<<data[1].toString()<<id<<" "<<data[2].toInt()<<"-"<<data[3].toDate().toString("yyyy-MM-dd");
    return true;
}

bool Database::changeRecordVocabulary(const int id, const QString &word, const QString &translation, int pack, const QDate date)
{
    QVariantList list;
    list<<word<<translation<<pack<<date;

    return changeRecordVocabulary(id,list);
}

bool Database::insertIntoTableLearned(const QVariantList &data)
{
    QSqlQuery query;

    query.prepare("INSERT INTO " TABLE_LEARNED " ( "
                                                    LEARNED_VOCABULARY_INDEX   ", "
                                                    LEARNED_DATE               ") "
                    "VALUES (:Index, :Date)"
                  );
    query.bindValue(":Index",data[0].toInt());
    query.bindValue(":Date",data[1].toDate());

    if(!query.exec())
    {
        qDebug() <<"error inserting into" <<TABLE_LEARNED;
        qDebug() <<query.lastError().text();
        return false;
    }

    return true;
}

bool Database::insertIntoTableLearned(const int vocabularyIndex,const QDate date)
{
    QVariantList list;
    list<<vocabularyIndex<<date;

    return insertIntoTableLearned(list);
}

bool Database::clearLearned()
{
    QSqlQuery query;

    query.prepare("DELETE FROM " TABLE_LEARNED ";");

    if(!query.exec())
            {
                qDebug() <<"error clearing Learned";
                qDebug() <<query.lastError().text();
                return false;
            }
    return true;
}

bool Database::importDatabase(const QString path)
{
    if(!QFile::exists(path))
        return false;

    closeDataBase();

    QFile::remove(MYPATH DATABASE_NAME);

    qDebug()<<"Copy from"<<path<<"To"<<MYPATH;


    QFile::copy(path,MYPATH +DATABASE_NAME);


    return connectToDatabase();

}

int Database::getWordPack(int id)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM " TABLE_VOCABULARY " WHERE id=:ID");
    query.bindValue(":ID",id);

    if(!query.exec()){
        qDebug() <<"error getting word pack. Word id="<<id;
        qDebug() <<query.lastError().text();
        return 1;
    }

    query.next();

    return query.value(VOCABULARY_PACK).toInt();
}

QDate Database::getWordDate(int id)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM " TABLE_VOCABULARY " WHERE id=:ID");
    query.bindValue(":ID",id);

    if(!query.exec()){
        qDebug() <<"error getting word pack. Word id="<<id;
        qDebug() <<query.lastError().text();
        return QDate();
    }

    query.next();

    return query.value(VOCABULARY_DATE).toDate();
}

bool Database::exportDatabase(const QString path, const QString fileName)
{
    if(QFile::exists(path+"/"+fileName))        //delete existed file
        QFile::remove(path+"/"+fileName);

    qDebug()<<"From "<<MYPATH DATABASE_NAME<<" To "<<path+"/"+fileName;

    return QFile::copy(MYPATH DATABASE_NAME,path+"/"+fileName);
    //qDebug()<<QFile::copy(DATABASE_NAME,"/release");
}

bool Database::isFileExist(const QString path, const QString fileName)
{
    return QFile::exists(path+"/"+fileName);
}

bool Database::openDataBase()
{
    db=QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName(MYPATH DATABASE_NAME);

    if(db.open())
        return true;

    return false;
}

//create new database
bool Database::restoreDataBase()
{
    if(this->openDataBase())
        return this->createTable();    //if we created db,we create table
    else
    {
        qDebug()<< "Failed to restore DataBase";
        return false;
    }
    return false;
}

//we use connection to fully remove connection to DB
void Database::closeDataBase()
{
    QString connection;
    connection=db.connectionName();

    db.close();
    db=QSqlDatabase();
    db.removeDatabase(connection);
}

//create all tables
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

    QSqlQuery query1;

    query1.prepare("CREATE TABLE " TABLE_LEARNED " ("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    LEARNED_VOCABULARY_INDEX    " INT, "
                    LEARNED_DATE                " DATE, "
                    "FOREIGN KEY (" LEARNED_VOCABULARY_INDEX") REFERENCES " TABLE_VOCABULARY "(id)"
                    " )"
                  );
    if(query.exec() && query1.exec())
        return true;
    return false;
}

bool Database::setDatabaseVersion(int version)
{
    QSqlQuery setVersion;
    setVersion.prepare("PRAGMA user_version="+QString::number(version));

    if(!setVersion.exec())
    {
        qDebug()<<"Error when setting database version!";
        return false;
    }
    return true;
}

int Database::getDatabaseVersion()
{
    QSqlQuery getVersion;
    getVersion.exec("PRAGMA user_version;");

    if(getVersion.next())        //if user_version exist
    {
        return getVersion.value(0).toInt();
    }
    else
    {
        setDatabaseVersion(1);   //if user_version doesn't exist,we set version to 1
        return 1;
    }
}
