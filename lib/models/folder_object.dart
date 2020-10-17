import 'package:flutter/foundation.dart'; // it gave us '@required'
// import 'package:flutter/material.dart'; // you'll need this to use 'Image' as a type, I think

class FolderObject {
  int _id; // wanted to make this one final, but couldn't figure out how while keeping it private
  String _name;
  String _parentName;
  // Image image;
  List<int> _folders = [];
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
  List<int> get folders => this._folders;
  List<int> get decks => this._decks;

  set name(String name) => this._name = name;

  // METHODS
  void addFolder(int folderId) {
    this._folders.add(folderId);
  }

  void addDeck(int deckId) {
    this._decks.add(deckId);
  }
}