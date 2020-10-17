import 'package:flutter/foundation.dart';

class DeckObject {
  int _id; // wanted to make this one final, but couldn't figure out how while keeping it private
  String _name;
  // TODO: these 3 might just be calculated when needed; it will be easier not to have to update them
  double _progress; // might split this into one per color later on
  int _seenQuantity; // the number of cards the user has never seen while he studies
  List<List<int>> _cardLists = [
    [], // 0 - unseenGroup
    [], // 1 - group1
    [], // 2
    [], // 3
    [], // 4
    [], // 5
  ];
  // List<int> _group1 = [];
  // List<int> _group2 = [];
  // List<int> _group3 = [];
  // List<int> _group4 = [];
  // List<int> _group5 = [];
  // List<int> _unseenGroup = [];

  // CONSTRUCTOR
  DeckObject({
    @required int id,
    @required String name,
  }) {
    this._id = id;
    this._name = name;
  }

  // GETTERS AND SETTERS
  String get name => this._name;
  int get cardQuantity {
    int quantity = 0;
    this._cardLists.forEach((list) => quantity += list.length);
    return quantity;
  }
  int get seenQuantity => this.cardQuantity - this._cardLists[0].length; // total - unseen

  // returns a numbrer in range [0.0, 1.0] that signifies the mastery over the decks content
  double get progress {
    if(this.cardQuantity == 0) return 1; // avoid division over 0 at the end

    double cardCompletion = this._cardLists[5].length.toDouble(); // cards from group 5 are considered completed at 100%
    cardCompletion += this._cardLists[4].length * 0.8; // those from group 4 just at 80%, etc.
    cardCompletion += this._cardLists[3].length * 0.6;
    cardCompletion += this._cardLists[2].length * 0.4;
    cardCompletion += this._cardLists[1].length * 0.2;
    return cardCompletion/this.cardQuantity;
  }

  set name(String name) => this._name = name;

  // METHODS
  void addCard({int cardId, int group = 0}) {
    this._cardLists[group].add(cardId);
  }
}