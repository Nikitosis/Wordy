#include "tutorials.h"

Tutorials::Tutorials(QObject *parent) : QObject(parent)
{

}

bool Tutorials::isVocabularyTutorial()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    bool res= settings.value("isVocabularyTutorial",1).toBool();

    settings.endGroup();

    return res;
}

bool Tutorials::isSprintTutorial()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    bool res= settings.value("isSprintTutorial",1).toBool();

    settings.endGroup();

    return res;
}

void Tutorials::passVocabularyTutorial()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    settings.setValue("isVocabularyTutorial",0);

    settings.endGroup();
}

void Tutorials::passSprintTutorial()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    settings.setValue("isSprintTutorial",0);

    settings.endGroup();
}
