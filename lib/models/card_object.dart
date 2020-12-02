import 'package:hive/hive.dart';

part 'card_object.g.dart';

@HiveType(typeId: 2, adapterName: 'CardAdapter')
class CardObject extends HiveObject {
  @HiveField(1)
  String _question;
  @HiveField(2)
  String _answer;
  @HiveField(3)
  int _group;

  // bool selected = false; // was meant to exist when cards had a checkbox in the deck overview instead of the trash icon

  CardObject({question = '', answer = '', group = 0}) {
    this.question = question;
    this.answer = answer;
    this.group = group; // validation is done in setter
  }

  // Getters and Setters
  String get question => this._question;
  String get answer => this._answer;
  int get group => this._group;

  set group(int group) {
    if (group >= 0 && group <= 5)
      this._group = group;
    else
      this._group = 0;
  }

  set question(String question) {
    this._question = question;
  }

  set answer(String answer) {
    this._answer = answer;
  }
}
