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
    QString stringQuery=getSprintQuery();

    updateLearned(stringQuery);

    QString getLearnedString="SELECT * FROM " TABLE_VOCABULARY " WHERE ";
    QSqlQuery getLearned;
    getLearned.exec("SELECT * FROM "TABLE_LEARNED);
    while(getLearned.next())                                                                                  //make query,which selects words in Vocabulary from Learned using id's
    {
        getLearnedString+=" id= "+QString::number(getLearned.value("Vocabulary_Index").toInt())+" OR ";
    }
    getLearnedString+=" id= -1 ORDER BY id";
    qDebug()<<getLearnedString;


    this->setQuery(getLearnedString);
}

void SprintListModel::updateLearned(QString mainQueryStr)
{
    QSqlQuery prevWords;
    prevWords.prepare("SELECT * FROM " TABLE_LEARNED " WHERE Date< :DATE");
    prevWords.bindValue(":DATE",QDate::currentDate().toString("yyyy-MM-dd"));
    prevWords.exec();
    if(prevWords.next())                                                                            //if we found words,which date is old
    {
        qDebug()<<"CHANGING WORDS";
        do                                                                                          //we update them to next pack level
        {
            int index=prevWords.value("Vocabulary_Index").toInt();                                  //get Id
            QSqlQuery getVocabulary;
            getVocabulary.prepare("SELECT * FROM " TABLE_VOCABULARY " WHERE id= :ID");              //get all the information from Vocabulary on that Id
            getVocabulary.bindValue(":ID",index);
            getVocabulary.exec();
            qDebug()<<getVocabulary.lastError();

            getVocabulary.next();

            db->changeRecordVocabulary(  index,                                                     //update to next pack
                                         getVocabulary.value("word").toString(),
                                         getVocabulary.value("translation").toString(),
                                         getVocabulary.value("pack").toInt()+1,
                                         QDate::currentDate());
        }while(prevWords.next());
        qDebug()<<"Changed Packs";
    }

    db->clearLearned();
    qDebug()<<"Cleared Learned";

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
