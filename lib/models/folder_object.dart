import 'dart:convert';

import 'package:flutter/foundation.dart'; // it gave us '@required'
import 'package:flutter/material.dart';
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
  FolderObject(
      {@required int id, @required String name, @required String parentName}) {
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

  void removeImage() {
    this._base64image = null;
    this.save();
  }

  Image detailsImage() {
    if (_base64image == null) {
      return Image.asset(
        'assets/images/mindspace_planet_gradient.png',
        fit: BoxFit.cover,
      );
    } else {
      return Image.memory(base64Decode(_base64image), fit: BoxFit.cover);
    }
  }

  DecorationImage backgroundImage() {
    // CONTINUE - validate it has an image
    if (_base64image == null) return null; // no decoration image

    return DecorationImage(
      // ty https://stackoverflow.com/questions/58427142/how-to-pass-image-asset-in-imageprovider-type
      // image: Image.asset('assets/images/fitoria.png').image,
      image: Image.memory(base64Decode(_base64image)).image,
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.5), BlendMode.luminosity),
    );
  }
}
