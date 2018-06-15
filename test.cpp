#include "test.h"

Test::Test()
{

}

void Test::newTest()
{
    options.clear();

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
        qDebug()<<"added";
    }
    qsrand(QTime(0,0,0).msecsTo(QTime::currentTime()));
    int wordNum= qrand()% words.size();

    int amount=0;
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
    options.push_back(words[wordNum].translation);
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

    qDebug()<<options[0]<<" "<<options[1]<<" "<<options[2]<<" "<<options[3];


}

void Test::resetWords()
{
    usedWords.clear();
}

QString Test::getMainWord()
{
    return mainWord;
}

QString Test::getMainAnsver()
{
    return mainAnsver;
}

QString Test::getOption(int num)
{
    if(num>=0 && num<options.size())
      return options[num];
    else{
        qDebug()<<"Out of options range!!!";
        return "";
    }
}