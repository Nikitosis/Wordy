#include "sprintlistmodel.h"

SprintListModel::SprintListModel(Database *db, QObject *parent):ListModel(parent)
{
    this->db=db;
    packs.push_back({1,0});
    packs.push_back({2,1});
    packs.push_back({3,5});
    packs.push_back({4,7});
    packs.push_back({5,16});

    readSettings();
}

SprintListModel::~SprintListModel()
{
    writeSettings();
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

void SprintListModel::setWordsInPack(int newWordsInPack)
{
    wordsInPack=newWordsInPack;
}

int SprintListModel::getWordsInPack()
{
    return wordsInPack;
}

void SprintListModel::readSettings()
{
    qDebug()<<"read Settings";
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("SprintModel");

    setWordsInPack(settings.value("wordsInPack",5).toInt());

    settings.endGroup();

}

void SprintListModel::writeSettings()
{
     qDebug()<<"write Settings";
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("SprintModel");

    settings.setValue("wordsInPack",getWordsInPack());

    settings.endGroup();

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
            db->changeRecordVocabulary(  prevWords.value("id").toInt(),                                //update to next pack
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

QString SprintListModel::getSprintQuery()      //get query that selects new words to learn
{
    QString stringQuery="SELECT * "
                       "FROM (      SELECT * "
                       "            FROM " TABLE_VOCABULARY
                                  " WHERE (pack= "+QString::number(packs[0].packNum)+
                                  " AND  julianday( " +"'"+QDate::currentDate().toString("yyyy-MM-dd")+"') -julianday(date)>= "+QString::number(packs[0].daysToUpdate)+")"
                                  " ORDER BY id DESC  "
                                  " LIMIT " +QString::number(getWordsInPack())+
                                  ") "
                                  " UNION ";      //for first pack

    for(int i=1;i<packs.size();i++)        //for other packs
    {
        stringQuery+="SELECT * "
                     "FROM (      SELECT * "
                     "            FROM " TABLE_VOCABULARY
                                " WHERE (pack= "+QString::number(packs[i].packNum)+
                                " AND  julianday( " +"'"+QDate::currentDate().toString("yyyy-MM-dd")+"') -julianday(date)>= "+QString::number(packs[i].daysToUpdate)+")"
                                " ORDER BY id DESC  "
                                ") ";
        if(i<packs.size()-1)
            stringQuery+=" UNION ";
    }
    qDebug()<<stringQuery;
    return stringQuery;
}
