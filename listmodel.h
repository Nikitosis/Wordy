#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <database.h>


class ListModel : public QSqlQueryModel
{
    Q_OBJECT
public:

    enum Roles{
        IdRole = Qt::UserRole + 1,
        WordRole,
        TranslationRole,
        PackRole,                                      //in which pack this word is
        DateRole                                       //last update date

    };


    explicit ListModel(QObject *parent=0);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

protected:

    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    int getId(int row);
    QString getWord(const int row) const;
    QString getTranslation(const int row) const;
    int getPack(const int row) const;
    QDate getDate(const int row) const;
};

#endif // LISTMODEL_H
