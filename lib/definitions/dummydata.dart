import 'package:mindspace/models/folder_object.dart';

int nextFolderId = 0;

Map<int, FolderObject> idFolderMap = {
  nextFolderId: FolderObject(id: nextFolderId++, name: 'drophy', parentName: 'Mindspace'), // root folder
  nextFolderId: FolderObject(id: nextFolderId++, name: '4-Japanese 1', parentName: 'drophy'),
  nextFolderId: FolderObject(id: nextFolderId++, name: '5-Japanese 2', parentName: 'drophy'),
  nextFolderId: FolderObject(id: nextFolderId++, name: '[CV] Lesson 1', parentName: '5-Japanese 2'),
  nextFolderId: FolderObject(id: nextFolderId++, name: '[CV] Lesson 2', parentName: '5-Japanese 2'),
};

void initDummyData() {
  idFolderMap[0].addFolder(1);
  idFolderMap[0].addFolder(2);
  idFolderMap[2].addFolder(3);
  idFolderMap[2].addFolder(4);
}