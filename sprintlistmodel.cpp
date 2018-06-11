#include "sprintlistmodel.h"

SprintListModel::SprintListModel(Database *db, QObject *parent):ListModel(parent)
{
    this->db=db;
    packs.push_back({1,0});
    packs.push_back({2,1});
    //packs.push_back({3,7});
    //packs.push_back({4,14});
}


void SprintListModel::updateModel()
{
    QString stringQuery;
    QVector<int> wordsPerPack=getWordsPerPack();

    for(int i=0;i<wordsPerPack.size();i++)
    {
        stringQuery+="SELECT * "
                     "FROM (      SELECT * "
                     "            FROM " TABLE_VOCABULARY
                                " WHERE (pack= "+QString::number(packs[i].packNum)+
                                " AND date<= "+"'"+QDate::currentDate().addDays(packs[i].daysToUpdate).toString("yyyy-MM-dd")+"')"
                                " OR  date = "+"'"+QDate::currentDate().toString("yyyy-MM-dd")+"'"
                                " LIMIT "+QString::number(wordsPerPack[i])+
                                ") ";
        if(i<wordsPerPack.size()-1)
            stringQuery+=" UNION ";
    }

    qDebug()<<stringQuery;
    /*QSqlQuery query;
    query.exec(stringQuery);
    qDebug()<<query.lastError();
    int amount=0;
    while(query.next())
        amount++;

    qDebug()<<amount;
    query.exec(stringQuery);*/
    QSqlQuery queryWasUpdated;
    queryWasUpdated.prepare("SELECT * FROM "TABLE_VOCABULARY " WHERE date= :DATE" );
    queryWasUpdated.bindValue(":DATE",QDate::currentDate().toString("yyyy-MM-dd"));
    queryWasUpdated.exec();
    if(!queryWasUpdated.next())
    {
        QSqlQuery updateQuery;
        updateQuery.exec(stringQuery);
        while(updateQuery.next())
        {
            db->changeRecord(updateQuery.value("id").toInt(),
                             updateQuery.value("word").toString(),
                             updateQuery.value("translation").toString(),
                             updateQuery.value("pack").toInt()+1,
                             QDate::currentDate());
            qDebug()<<"OK";
        }
    }

    this->setQuery(stringQuery);
}

QVector<int> SprintListModel::getWordsPerPack()
{
    QVector<int> wordsPerPack;
    for(int i=0;i<packs.size();i++)
    {
        QSqlQuery query;
        query.prepare("SELECT * FROM " TABLE_VOCABULARY " WHERE pack= :PACK AND Date<= :DATE");
        query.bindValue(":PACK",packs[i].packNum);
        query.bindValue(":DATE",QDate::currentDate().addDays(packs[i].daysToUpdate).toString("yyyy-MM-dd"));
        query.exec();
        int amount=0;
        while(query.next())
            amount++;
        wordsPerPack.push_back(amount);
    }
    int wordsInPack=maxWords/packs.size();
    QVector<int> resWordsPerPack(wordsPerPack.size());
    int wordsAmount=maxWords;
    for(int i=0;i<resWordsPerPack.size();i++)
    {
        resWordsPerPack[i]=qMin(wordsInPack,wordsPerPack[i]);
        wordsAmount-=resWordsPerPack[i];
    }
    for(int i=0;i<resWordsPerPack.size();i++)
    {
        int plusAmount=qMin(wordsAmount,wordsPerPack[i]-resWordsPerPack[i]);
        resWordsPerPack[i]+=plusAmount;
        wordsAmount-=plusAmount;
    }
    qDebug()<<"---------";
    for(int i=0;i<resWordsPerPack.size();i++)
        qDebug()<<resWordsPerPack[i];

    return resWordsPerPack;
}
