import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mindspace/models/card_object.dart';

class DeckObject {
  int _id; // wanted to make this one final, but couldn't figure out how while keeping it private
  String _name;
  List<CardObject> _cards = [];

  // //! We might just want to have them separated by groups when studying
  // List<List<CardObject>> _cardLists = [
  //   [], // 0 - unseenGroup
  //   [], // 1 - group1
  //   [], // 2
  //   [], // 3
  //   [], // 4
  //   [], // 5
  // ];

  CardObject _currentCard; // card that's currently being shown in studying mode
  List<Queue<CardObject>> _cardQueues = [
    Queue(), // 0 - unseenGroup
    Queue(), // 1 - group1
    Queue(), // 2
    Queue(), // 3
    Queue(), // 4
    Queue(), // 5
  ];

  // CONSTRUCTOR
  DeckObject({
    @required int id,
    @required String name,
  }) {
    this._id = id;
    this._name = name;
  }

  // GETTERS AND SETTERS
  set name(String name) => this._name = name;

  String get name => this._name;
  List<CardObject> get cards => this._cards;
  int get cardQuantity => this._cards.length;
  int get seenQuantity {
    int count = 0;
    this._cards.forEach((card) {
      if(card.group != 0) count++;
    });
    return count;
  }
  // int get cardQuantity {
  //   int quantity = 0;
  //   this._cardLists.forEach((list) => quantity += list.length);
  //   return quantity;
  // }
  // int get seenQuantity => this.cardQuantity - this._cardLists[0].length; // total - unseen

  // returns a numbrer in range [0.0, 1.0] that signifies the mastery over the decks content
  double get progress {
    if(this.cardQuantity == 0) return 1; // avoid division over 0 at the end

    double cardCompletion = 0;
    this._cards.forEach((card) { 
      switch(card.group) {
        case 5: { cardCompletion += 1; } break;
        case 4: { cardCompletion += 0.8; } break;
        case 3: { cardCompletion += 0.6; } break;
        case 2: { cardCompletion += 0.4; } break;
        case 1: { cardCompletion += 0.2; } break;
        default: break;
      }
    });

    return cardCompletion/this.cardQuantity;
  }
  // double get progress2 {
  //   if(this.cardQuantity == 0) return 1; // avoid division over 0 at the end

  //   double cardCompletion = this._cardLists[5].length.toDouble(); // cards from group 5 are considered completed at 100%
  //   cardCompletion += this._cardLists[4].length * 0.8; // those from group 4 just at 80%, etc.
  //   cardCompletion += this._cardLists[3].length * 0.6;
  //   cardCompletion += this._cardLists[2].length * 0.4;
  //   cardCompletion += this._cardLists[1].length * 0.2;
  //   return cardCompletion/this.cardQuantity;
  // }

  // METHODS
  void addCard({String question = '', String answer = ''}) {
    this._cards.add(CardObject(question: question, answer: answer, group: 0));
  }

  void removeCard(int index) {
    if(index >= this._cards.length || index < 0) return;
    this._cards.removeAt(index);
  }

  void changeGroup(int cardIndex, int newGroup) {
    this._cards[cardIndex].group = newGroup;
  }

  void shuffle() {
    // Make a copy of card list
    List<CardObject> aidingList = [];
    this._cards.forEach((card) { 
      aidingList.add(card);
    });

    // Clear queues
    _cardQueues.forEach((queue) => queue.clear());

    // Draw cards at random and put them in their queue
    final _random = new Random();

    while(aidingList.isNotEmpty) {
      int index = _random.nextInt(aidingList.length);
      CardObject card = aidingList.removeAt(index);
      _cardQueues[card.group].add(card);
    }
  }

  // Picks a card from one of the queues, sets it as the currentCard and returns it
  CardObject nextCard() {
    if(cardQuantity == 0) return null;

    // Generate an array with 1 fives, 2 fours, 3 threes, 4 twos, 5 ones and 6 zeros (if all queues exist)
    List<int> aidingList = [];
    for(int group = 0, quantity = 6; group <= 5; group++, quantity--) {
      if(_cardQueues[group].isEmpty) continue; // if a queue is empty, no point in considering it
      for(int q = quantity; q > 0; q--) aidingList.add(group);
    }

    // Select one of the non empty queues at 'random' (but giving preference to the ones from lower groups)
    final _random = new Random();
    int selectedGroup = aidingList[_random.nextInt(aidingList.length)];

    // Extract a card from that queue, set as current card and return it
    return _currentCard = _cardQueues[selectedGroup].removeFirst();
  }

  // Changes the group of the currentCard and puts it into a queue accordingly
  // TODO: add card to a waiting queue so it can't appear multiple times in a row
  // TODO pt2: the queue could have a max size of 5 or so, but make it smaller or don't use it if there's just a couple cards
  void recolorCard({int group}) {
    this._currentCard.group = group;
    _cardQueues[group].add(this._currentCard);
  }

  void resetProgress() {
    this._cards.forEach((card) => card.group = 0);
  }

  // PRIVATE METHODS
  // CardObject getCardAt(int index) {
  //   this._cardLists.forEach((group) {
  //     if(index >= group.length) index -= this._cardLists[0].length;
  //     else return group.removeAt(index);
  //   });
  //   return null; // will just get here if the index was invalid
  // }
}