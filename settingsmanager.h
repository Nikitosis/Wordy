#ifndef SETTINGSMANAGER_H
#define SETTINGSMANAGER_H

#include <QObject>
#include <QSettings>

class SettingsManager : public QObject
{
    Q_OBJECT
public:
        SettingsManager();
        SettingsManager(const SettingsManager&);

        static SettingsManager &getInstance();

signals:

public slots:
        bool isVocabularyTutorial();
        bool isSprintTutorial();
        void passVocabularyTutorial();
        void passSprintTutorial();
        void resetTutorials();

        int getWordsInPack();
        void setWordsInPack(int wordsInPack);
};

#endif // SETTINGSMANAGER_H
