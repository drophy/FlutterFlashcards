import 'package:mindspace/models/folder_object.dart';
import 'package:mindspace/models/deck_object.dart';

int nextFolderId = 0;
int nextDeckId = 0;

Map<int, FolderObject> idFolderMap = {
  nextFolderId: FolderObject(id: nextFolderId++, name: 'drophy', parentName: 'Mindspace'), // root folder
  nextFolderId: FolderObject(id: nextFolderId++, name: 'Japanese 1', parentName: 'drophy'),
  nextFolderId: FolderObject(id: nextFolderId++, name: 'Japanese 2', parentName: 'drophy'),
  nextFolderId: FolderObject(id: nextFolderId++, name: '[Anime] Shield Hero', parentName: 'Japanese 2'),
  nextFolderId: FolderObject(id: nextFolderId++, name: '[Anime] Sword Art Online 4: WotU', parentName: 'Japanese 2'),
};
Map<int, DeckObject> idDeckMap = {
  nextDeckId: DeckObject(id: nextDeckId++, name: '[CV] Lesson 1'),
  nextDeckId: DeckObject(id: nextDeckId++, name: '[CV] Lesson 2'),
};

void initDummyData() {
  // Give cards to decks
  idDeckMap[0].addCard(question: 'sea; ocean; waters​', answer: 'うみ (海)'); 
  idDeckMap[0].addCard(question: 'stamp (postage)', answer: 'きって (切手)');
  idDeckMap[0].addCard(question: 'tickets (entradas)', answer: 'きっぷ');
  idDeckMap[0].addCard(question: 'surfing', answer: 'サーフィン');
  idDeckMap[0].addCard(question: 'homework', answer: 'しゅくだい (宿題)'); 
  idDeckMap[0].addCard(question: 'food', answer: 'たべもの (食べ物) - The last kanji means "thing/stuff" so literally it\'s like "something to eat" lol'); 
  idDeckMap[0].addCard(question: 'drink; beverage​', answer: 'のみもの (飲み物) - Same ending as たべもの, so it\'s like "thing to drink"'); 
  idDeckMap[0].addCard(question: 'birthday', answer: 'たんじょうび (誕生日)'); 
  idDeckMap[0].addCard(question: 'exam', answer: 'テスト or しけん (試験)'); 
  idDeckMap[0].addCard(question: 'clima', answer: 'てんき (天気)');
  idDeckMap[0].changeGroup(1, 1); // to see the different colors
  idDeckMap[0].changeGroup(2, 2); 
  idDeckMap[0].changeGroup(3, 3); 
  idDeckMap[0].changeGroup(4, 4); 
  idDeckMap[0].changeGroup(5, 5); 

  // Give folders to folders
  idFolderMap[0].addFolder(1);
  idFolderMap[0].addFolder(2);
  idFolderMap[2].addFolder(3);
  idFolderMap[2].addFolder(4);

  // Give decks to folders
  idFolderMap[2].addDeck(0);
  idFolderMap[2].addDeck(1);
}