#include "sprintlistmodel.h"

SprintListModel::SprintListModel(QObject *parent):ListModel(parent)
{
}


void SprintListModel::updateModel()
{
    this->setQuery("SELECT * FROM " TABLE_VOCABULARY " WHERE pack=1 ORDER BY id DESC");
}
