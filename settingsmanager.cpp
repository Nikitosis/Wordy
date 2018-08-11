#include "settingsmanager.h"

SettingsManager::SettingsManager()
{

}

SettingsManager &SettingsManager::getInstance()
{
    static SettingsManager *_instance=nullptr;
    if(_instance==nullptr)
    {
        _instance=new SettingsManager();
    }
    return *_instance;
}

bool SettingsManager::isVocabularyTutorial()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    bool res= settings.value("isVocabularyTutorial",1).toBool();

    settings.endGroup();

    return res;
}

bool SettingsManager::isSprintTutorial()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    bool res= settings.value("isSprintTutorial",1).toBool();

    settings.endGroup();

    return res;
}

void SettingsManager::passVocabularyTutorial()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    settings.setValue("isVocabularyTutorial",0);

    settings.endGroup();
}

void SettingsManager::passSprintTutorial()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    settings.setValue("isSprintTutorial",0);

    settings.endGroup();
}

void SettingsManager::resetTutorials()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("Tutorials");

    settings.setValue("isSprintTutorial",1);
    settings.setValue("isVocabularyTutorial",1);

    settings.endGroup();
}

int SettingsManager::getWordsInPack()
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("SprintModel");

    int res=settings.value("wordsInPack",5).toInt();

    settings.endGroup();

    return res;
}

void SettingsManager::setWordsInPack(int wordsInPack)
{
    QSettings settings("PupovCorp","Wordy");
    settings.beginGroup("SprintModel");

    settings.setValue("wordsInPack",wordsInPack);

    settings.endGroup();
}
