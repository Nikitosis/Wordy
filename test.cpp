#include "test.h"

Test::Test()
{

}

void Test::updateTest()
{
    QSqlQuery query;
    query.exec("SELECT * FROM " TABLE_VOCABULARY );

    QVector<Word> words;
    while(query.next())
    {
        words.push_back({query.value(0).toInt(),
                            query.value(1).toString(),
                            query.value(2).toString(),
                            query.value(3).toInt(),
                            query.value(4).toDate()
                        });
    }
    qsrand(QTime(0,0,0).msecsTo(QTime::currentTime()));
    int wordNum= rand()% words.size();
    qDebug()<<"AA";

    int amount;
    while(usedWords.contains(wordNum))
    {
        wordNum=(wordNum+1) % words.size();
        amount++;
        if(amount>words.size())
        {
            resetWords();
            amount=0;
        }
    }

    mainWord=words[wordNum].word;
    mainAnsver=words[wordNum].translation;
    usedWords.insert(wordNum);

    QSet<int> UsedOption;
    UsedOption.insert(wordNum);
    for(int i=0;i<3;i++)
    {
        int randNum=rand()% words.size();
        amount=0;
        while(UsedOption.contains(randNum))
        {
            randNum=(randNum+1)%words.size();
        }
        options.push_back(words[randNum].translation);

        UsedOption.insert(randNum);
    }

    std::random_shuffle(options.begin(),options.end());
}

void Test::resetWords()
{

}

QString Test::getMainWord()
{
    return mainWord;
}

QString Test::getMainAnsver()
{
    return mainAnsver;
}

QVariantList Test::getOptions()
{
    return options;
}
