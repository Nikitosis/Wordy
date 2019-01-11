#include "test.h"

Test::Test(QObject *parent):QObject(parent)
{

}

void Test::newTest(int fromPack, int toPack)
{
    options.clear();

    if(fromPack>toPack)
        std::swap(fromPack,toPack);

    QVector<Test::Word> words=getAllWords(fromPack,toPack);

    if(words.size()<4)
    {
        qDebug()<<"Cannot init test. Too few words!";
        return;
    }

    qsrand(QTime(0,0,0).msecsTo(QTime::currentTime()));

    int wordNum= getUnusedWordNum(words.size());


    mainWord=words[wordNum].word;
    mainAnsver=words[wordNum].translation;
    options.push_back(words[wordNum].translation);
    usedWords.insert(wordNum);


    //fill options with false ansvers
    QSet<int> UsedOption;
    UsedOption.insert(wordNum);
    for(int i=0;i<3;i++)
    {
        int randNum=rand()% words.size();
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

//get all words from Vocabulary,wich packs are between fromPack and toPack
QVector<Test::Word> Test::getAllWords(int fromPack, int toPack)
{
    if(fromPack>toPack)
        std::swap(fromPack,toPack);

    QSqlQuery getMatchWords;
    getMatchWords.prepare("SELECT * FROM " TABLE_VOCABULARY " WHERE " VOCABULARY_PACK " >= :FROMPACK AND " VOCABULARY_PACK " <= :TOPACK");
    getMatchWords.bindValue(":FROMPACK",fromPack);
    getMatchWords.bindValue(":TOPACK",toPack);

    if(!getMatchWords.exec())
    {
        qDebug()<<"Error: can't get words from Vocabulary from FromPack to ToPack";
        return {};
    }

    QVector<Word> words;
    while(getMatchWords.next())
    {
        words.push_back({getMatchWords.value(0).toInt(),
                            getMatchWords.value(1).toString(),
                            getMatchWords.value(2).toString(),
                            getMatchWords.value(3).toInt(),
                            getMatchWords.value(4).toDate()
                        });
        qDebug()<<"added";
    }
    qDebug()<<"Test words amount:"<<words.size();
    return words;
}

//get index of unused word
int Test::getUnusedWordNum(int wordsAmount)
{
    int wordNum= qrand()% wordsAmount;

    int amount=0;
    while(usedWords.contains(wordNum))
    {
        wordNum=(wordNum+1) % wordsAmount;
        amount++;
        if(amount>wordsAmount)
        {
            resetWords();
            amount=0;
        }
    }
    return wordNum;
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

//we take every word,which pack corresponds to our pack range(fromPack,toPack)
//and check if their amount>=4(if less, we cannot build test, because we have 4 options)
bool Test::canBuildTest(int fromPack, int toPack)
{
    if(fromPack>toPack)
        std::swap(fromPack,toPack);

    QVector<Test::Word> words=getAllWords(fromPack,toPack);

    return words.size()>=4;
}

