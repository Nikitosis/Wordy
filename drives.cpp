#include "drives.h"
#include <QDebug>

Drives::Drives(QObject *parent) : QObject(parent)
{

}

QStringList Drives::getDrives()
{
    QStringList res;
    foreach(QFileInfo info, QDir::drives())
    {
        if(info.absolutePath()!="/" && info.absolutePath()!="")
        {
            res<<info.absolutePath();
            qDebug()<<"PATH"<<info.absolutePath();
        }
    }
    return res;
}
