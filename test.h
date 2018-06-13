#ifndef TEST_H
#define TEST_H

#include <QString>
#include <QStringList>
#include <QList>
#include <QSqlQuery>
#include <QSet>
#include <QVector>
#include <QDebug>
#include <QtGlobal>
#include <QObject>
#include <algorithm>
#include <random>
#include <QVariantList>
#include <QTime>

#include <database.h>


class Test:public QObject
{
    Q_OBJECT
public:

    struct Word{
        int     id;
        QString word;
        QString translation;
        int     pack;
        QDate   date;
    };

    Test();

public slots:
    void newTest();
    void resetWords();
    QString getMainWord();
    QString getMainAnsver();
    QString getOption(int num);

private:
    QString mainWord;
    QString mainAnsver;
    QVector<QString> options;
    QSet<int> usedWords;
};

#endif // TEST_H
