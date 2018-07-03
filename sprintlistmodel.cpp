#include "sprintlistmodel.h"

SprintListModel::SprintListModel(Database *db, QObject *parent):ListModel(parent)
{
    this->db=db;
    packs.push_back({1,0});
    packs.push_back({2,1});
    packs.push_back({3,5});
    packs.push_back({4,7});
    packs.push_back({5,16});
}


void SprintListModel::updateModel()
{
    updateLearned();

    this->setQuery("SELECT "TABLE_VOCABULARY".* "
                   " FROM " TABLE_VOCABULARY " JOIN " TABLE_LEARNED " ON " TABLE_VOCABULARY".id " " = " TABLE_LEARNED"."LEARNED_VOCABULARY_INDEX);
}

void SprintListModel::updateLearned()
{
    increaseLearnedPacks();    //if we have already learned some words,we increase their packs

    db->clearLearned();
    qDebug()<<"Cleared Learned";

    fillLearned();            //fill Learned table with new words to learn
}

void SprintListModel::increaseLearnedPacks()
{
    QSqlQuery prevWords;
    prevWords.prepare("SELECT " TABLE_VOCABULARY".* "
                      " FROM " TABLE_VOCABULARY " JOIN " TABLE_LEARNED " ON " TABLE_VOCABULARY".id " " = " TABLE_LEARNED"."LEARNED_VOCABULARY_INDEX
                      " WHERE " TABLE_LEARNED"."LEARNED_DATE " < :DATE");                 //used join to combine two tables(all vocabulary words, which are in learned with late date
    prevWords.bindValue(":DATE",QDate::currentDate().toString("yyyy-MM-dd"));
    prevWords.exec();

    QSqlQuery learnedWords;
    learnedWords.exec("SELECT * FROM "TABLE_LEARNED);
    qDebug()<<"----Started Updating Packs ------";
    while(prevWords.next())                                                                            //if we found words,which date is old
    {
        learnedWords.next();
        QDate learnedDate=learnedWords.value("date").toDate();
            db->changeRecordVocabulary(  prevWords.value("id").toInt(),                                                     //update to next pack
                                         prevWords.value("word").toString(),
                                         prevWords.value("translation").toString(),
                                         prevWords.value("pack").toInt()+1,
                                         learnedDate);

    }
    qDebug()<<"----Ended Updating Packs ------";

}

void SprintListModel::fillLearned()
{
    QSqlQuery addWords;
    addWords.exec(getSprintQuery());

    while(addWords.next())                                                                          //add words to learned pack
    {
        qDebug()<<addWords.value("id").toInt()<<addWords.value("date").toDate();
        db->insertIntoTableLearned(addWords.value("id").toInt(),
                                   QDate::currentDate());
    }
    qDebug()<<"Added to Learned";
}

QVector<int> SprintListModel::getWordsPerPack()      //makes vector,which contains, how many words in each pack
{
    QVector<int> wordsPerPack;
    for(int i=0;i<packs.size();i++)
    {
        QSqlQuery query;
        query.prepare("SELECT * FROM " TABLE_VOCABULARY " WHERE pack= :PACK AND julianday(:TODAY) - julianday(date) >= :UPDATEDAYS");
        query.bindValue(":PACK",packs[i].packNum);
        query.bindValue(":TODAY",QDate::currentDate().toString("yyyy-MM-dd"));
        query.bindValue(":UPDATEDAYS",packs[i].daysToUpdate);
        query.exec();
        int amount=0;
        while(query.next())
            amount++;
        wordsPerPack.push_back(amount);
    }
    int wordsInPack=maxWords/packs.size();
    QVector<int> resWordsPerPack(wordsPerPack.size());
    int wordsAmount=maxWords;

    for(int i=0;i<resWordsPerPack.size();i++)                              //try to give each pack equal amount of words
    {
        resWordsPerPack[i]=qMin(wordsInPack,wordsPerPack[i]);
        wordsAmount-=resWordsPerPack[i];
    }

    for(int i=0;i<resWordsPerPack.size();i++)                              //if we have remaining words,we add them to other packs
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

QString SprintListModel::getSprintQuery()      //get query that selects new words to learn
{
    QString stringQuery;
    QVector<int> wordsPerPack=getWordsPerPack();

    for(int i=0;i<wordsPerPack.size();i++)
    {
        stringQuery+="SELECT * "
                     "FROM (      SELECT * "
                     "            FROM " TABLE_VOCABULARY
                                " WHERE (pack= "+QString::number(packs[i].packNum)+
                                " AND  julianday( " +"'"+QDate::currentDate().toString("yyyy-MM-dd")+"') -julianday(date)>= "+QString::number(packs[i].daysToUpdate)+")"
                                " ORDER BY date DESC, id  "
                                " LIMIT "+QString::number(wordsPerPack[i])+
                                ") ";
        if(i<wordsPerPack.size()-1)
            stringQuery+=" UNION ";
    }
    qDebug()<<stringQuery;
    return stringQuery;
}
