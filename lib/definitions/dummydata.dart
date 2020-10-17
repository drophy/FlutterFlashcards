import 'package:mindspace/models/folder_object.dart';
import 'package:mindspace/models/deck_object.dart';

int nextFolderId = 0;
int nextDeckId = 0;

Map<int, FolderObject> idFolderMap = {
  nextFolderId: FolderObject(id: nextFolderId++, name: 'drophy', parentName: 'Mindspace'), // root folder
  nextFolderId: FolderObject(id: nextFolderId++, name: '4-Japanese 1', parentName: 'drophy'),
  nextFolderId: FolderObject(id: nextFolderId++, name: '5-Japanese 2', parentName: 'drophy'),
  nextFolderId: FolderObject(id: nextFolderId++, name: '[CV] Lesson 1', parentName: '5-Japanese 2'),
  nextFolderId: FolderObject(id: nextFolderId++, name: '[CV] Lesson 2', parentName: '5-Japanese 2'),
};
Map<int, DeckObject> idDeckMap = {
  nextDeckId: DeckObject(id: nextDeckId++, name: '[CV] Lesson 1'),
  nextDeckId: DeckObject(id: nextDeckId++, name: '[CV] Lesson 2'),
};

void initDummyData() {
  // Give cards to decks
  idDeckMap[0].addCard(cardId: 0); 
  idDeckMap[0].addCard(cardId: 1);
  idDeckMap[0].addCard(cardId: 2);
  idDeckMap[0].addCard(cardId: 3);
  idDeckMap[0].addCard(cardId: 4, group: 5); // add 1 to the 100% mastery group

  // Give folders to folders
  idFolderMap[0].addFolder(1);
  idFolderMap[0].addFolder(2);
  idFolderMap[2].addFolder(3);
  idFolderMap[2].addFolder(4);

  // Give decks to folders
  idFolderMap[2].addDeck(0);
  idFolderMap[2].addDeck(1);
}