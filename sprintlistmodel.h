#ifndef SPRINTLISTMODEL_H
#define SPRINTLISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QVector>
#include <QDate>
#include <QtGlobal>

#include <database.h>
#include <listmodel.h>
#include <settingsmanager.h>

struct Pack{
    int packNum;
    int daysToUpdate;
};
const int maxWords=10;

class SprintListModel: public ListModel
{
    Q_OBJECT
public:
    SprintListModel(Database *db,QObject *parent=0);
    ~SprintListModel();

public slots:
    void updateModel();
    void updateModelShuffle();

    bool isAnyWords();

private:
    void updateLearned();
    void increasePacksOfLearnedWords();
    void fillLearned();
protected:
    QString getSprintQuery();

    QVector<Pack> packs;
    int wordsInPack;
    Database *db;
};

#endif // SPRINTLISTMODEL_H
