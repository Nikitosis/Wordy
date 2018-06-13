#ifndef SPRINTLISTMODEL_H
#define SPRINTLISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QVector>
#include <QDate>
#include <QtGlobal>
#include <database.h>
#include <listmodel.h>

struct Pack{
    int packNum;
    int daysToUpdate;
};
const int maxWords=5;

class SprintListModel: public ListModel
{
    Q_OBJECT
public:
    SprintListModel(Database *db,QObject *parent=0);

public slots:
    void updateModel();
    void updateWords(QString mainQueryStr);
protected:
    QVector<int> getWordsPerPack();
    QString      getSprintQuery();
    QVector<Pack> packs;
    Database *db;
};

#endif // SPRINTLISTMODEL_H
