import 'package:flutter/foundation.dart'; // it gave us '@required'
import 'package:hive/hive.dart';

part 'folder_object.g.dart';

@HiveType(typeId: 1, adapterName: 'FolderAdapter') 
class FolderObject extends HiveObject {
  @HiveField(1)
  int _id; // wanted to make this one final, but couldn't figure out how while keeping it private
  @HiveField(2)
  String _name;
  @HiveField(3)
  String _parentName;
  @HiveField(4)
  String _base64image; // TODO - support these
  @HiveField(5)
  List<int> _folders = [];
  @HiveField(6)
  List<int> _decks = [];

  // CONSTRUCTOR
  FolderObject({
    @required int id,
    @required String name,
    @required String parentName
  }) {
    this._id = id;
    this._name = name;
    this._parentName = parentName;
  }

  // GETTERS AND SETTERS

  String get name => this._name;
  String get parentName => this._parentName;
  String get base64image => this._base64image;
  List<int> get folders => this._folders;
  List<int> get decks => this._decks;

  set name(String name) {
    this._name = name;
  } 
  set base64image(String base64image) {
    this._base64image = base64image;
  }

  // METHODS
  void addFolder(int folderId) {
    this._folders.add(folderId);
    this.save();
  }

  void addDeck(int deckId) {
    this._decks.add(deckId);
    this.save();
  }
}