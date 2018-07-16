#ifndef TUTORIALS_H
#define TUTORIALS_H

#include <QObject>
#include <QSettings>

class Tutorials : public QObject
{
    Q_OBJECT
public:
    explicit Tutorials(QObject *parent = nullptr);

signals:

public slots:
    bool isVocabularyTutorial();
    bool isSprintTutorial();

    void passVocabularyTutorial();
    void passSprintTutorial();
};

#endif // TUTORIALS_H
