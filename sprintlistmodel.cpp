#include "sprintlistmodel.h"

SprintListModel::SprintListModel(Database *db, QObject *parent):ListModel(parent)
{
    this->db=db;

    //install packs,where first number-pack num; second-days untill next revision of the word
    packs.push_back({1,0});
    packs.push_back({2,1});
    packs.push_back({3,5});
    packs.push_back({4,7});
    packs.push_back({5,16});
}

SprintListModel::~SprintListModel()
{
}


void SprintListModel::updateModel()
{
    updateLearned();

    this->setQuery("SELECT "TABLE_VOCABULARY".* "
                   " FROM " TABLE_VOCABULARY " JOIN " TABLE_LEARNED " ON " TABLE_VOCABULARY".id " " = " TABLE_LEARNED"."LEARNED_VOCABULARY_INDEX);
}

void SprintListModel::updateModelShuffle()
{
    updateLearned();

    this->setQuery(" SELECT "TABLE_VOCABULARY".* "
                   " FROM " TABLE_VOCABULARY " JOIN " TABLE_LEARNED " ON " TABLE_VOCABULARY".id " " = " TABLE_LEARNED"."LEARNED_VOCABULARY_INDEX
                   " ORDER BY random()");

    QString query=" SELECT "TABLE_VOCABULARY".* "
                  " FROM " TABLE_VOCABULARY " JOIN " TABLE_LEARNED " ON " TABLE_VOCABULARY".id " " = " TABLE_LEARNED"."LEARNED_VOCABULARY_INDEX
                  " ORDER BY random()";
    qDebug()<<query;
}

void SprintListModel::updateLearned()
{
    increasePacksOfLearnedWords();    //if we have already learned some words,we increase their packs

    db->clearLearned();
    qDebug()<<"Cleared Learned";

    fillLearned();            //fill Learned table with new words to learn
}

bool SprintListModel::isAnyWords()
{
    QSqlQuery words;
    words.exec(getSprintQuery());

    if(words.next())
        return true;

    return false;
}

//if we have words in Learned,which date < currentDate , then we update these words(increase their pack
//+change their date to the date,when they were repeated last time
void SprintListModel::increasePacksOfLearnedWords()
{
    QSqlQuery prevWords;
    prevWords.prepare("SELECT " TABLE_VOCABULARY".* " " , "
                                TABLE_LEARNED"."LEARNED_DATE " AS LearnedDate "
                      " FROM " TABLE_VOCABULARY " JOIN " TABLE_LEARNED " ON " TABLE_VOCABULARY".id " " = " TABLE_LEARNED"."LEARNED_VOCABULARY_INDEX
                      " WHERE " TABLE_LEARNED"."LEARNED_DATE " < :DATE");                 //used join to combine two tables(all vocabulary words, which are in learned with late date
    prevWords.bindValue(":DATE",QDate::currentDate().toString("yyyy-MM-dd"));
    if(!prevWords.exec())
    {
        qDebug()<<"Error: can't get PrevWords in Sprint";
        return;
    }

    qDebug()<<"----Started Updating Packs ------";
    while(prevWords.next())                                                                            //if we found words,which date is old
    {
            db->changeRecordVocabulary(  prevWords.value("id").toInt(),                                //update to next pack
                                         prevWords.value("word").toString(),
                                         prevWords.value("translation").toString(),
                                         prevWords.value("pack").toInt()+1,
                                         prevWords.value("LearnedDate").toDate());                    //change date to date, when they were repeated

    }
    qDebug()<<"----Ended Updating Packs ------";

}

//fill Learned with new words
//in Learned we assign words' date to currentDate, so tomorrow we can find out, which words have already been repeated
void SprintListModel::fillLearned()
{
    QSqlQuery addWords;
    if(!addWords.exec(getSprintQuery()))
    {
        qDebug()<<"Error: can't fill Learned table";
        return;
    }

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
                                  " LIMIT " +QString::number(SettingsManager::getInstance().getWordsInPack())+
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
