#ifndef SPRINTLISTMODEL_H
#define SPRINTLISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <database.h>
#include <listmodel.h>


class SprintListModel: public ListModel
{
    Q_OBJECT
public:
    SprintListModel(QObject *parent=0);

public slots:
    void updateModel();
};

#endif // SPRINTLISTMODEL_H
