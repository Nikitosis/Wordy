#ifndef DRIVES_H
#define DRIVES_H

#include <QDir>
#include <QFileInfo>
#include <QStringList>

class Drives : public QObject
{
    Q_OBJECT
public:
    explicit Drives(QObject *parent = nullptr);

signals:

public slots:
    QStringList getDrives();
};

#endif // DRIVES_H
