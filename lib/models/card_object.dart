class CardObject {
  String question;
  String answer;
  bool selected = false;
  int _group;

  CardObject({this.question = '', this.answer = '', group = 0}) {
    this.group = group; // validation is done in setter
  }

  // Getters and Setters
  int get group => this._group;
  set group(int group) {
    if(group >= 0 && group <= 5) this._group = group;
    else this._group = 0;
  }
}