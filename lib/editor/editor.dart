import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/explorer/bloc/explorer_bloc.dart';
import 'package:mindspace/models/card_object.dart';
import 'package:mindspace/models/deck_object.dart';

class Editor extends StatefulWidget {
  final DeckObject deck;
  final int initialIndex;
  Editor({Key key, @required this.deck, this.initialIndex = 0})
      : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  int currentIndex;
  List<CardObject> cards;
  TextEditingController _questionInputController;
  TextEditingController _answerInputController;

  // // CONTINUE . it says the context doesn't contain a Bloc/Cubit of such type
  // void updateAncestors(){
  //   return;
  //   BlocProvider.of<ExplorerBloc>(context).add(UpdateEvent());
  // }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    cards = widget.deck.cards;
    // https://stackoverflow.com/questions/43214271/how-do-i-supply-an-initial-value-to-a-text-field
    _questionInputController =
        TextEditingController(text: cards[currentIndex].question);
    _answerInputController =
        TextEditingController(text: cards[currentIndex].answer);
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;
    final ExplorerBloc _bloc = BlocProvider.of<ExplorerBloc>(context);

    return Scaffold(
      backgroundColor: tailwindGray700,
      ///// APP BAR /////
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          print('IT WORKED 3');
          _bloc.add(UpdateEvent());
          Navigator.maybePop(
              context); // not sure of how it's different to pop(), but it says 'leading' uses this by default
        }),
        backgroundColor: tailwindGray900,
        title: Text('Editor'),
        actions: [
          Row(
            children: [
              IconButton(
                color: tailwindGray100,
                disabledColor: tailwindGray700,
                icon: Icon(Icons.navigate_before),
                onPressed: currentIndex == 0
                    ? null
                    : () {
                        setState(() {
                          currentIndex--;
                        });
                        _updateCardText();
                      },
              ),
              Text(
                '${currentIndex + 1}/${widget.deck.cards.length}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: tailwindGray100),
              ),
              IconButton(
                color: tailwindGray100,
                disabledColor: tailwindGray700,
                icon: Icon(Icons.navigate_next),
                onPressed: currentIndex == widget.deck.cards.length - 1
                    ? null
                    : () {
                        setState(() {
                          currentIndex++;
                        });
                        _updateCardText();
                      },
              ),
              IconButton(
                padding: EdgeInsets.all(0),
                color: tailwindGray100,
                disabledColor: tailwindGray700,
                icon: Icon(Icons.add),
                onPressed: () {
                  widget.deck.addCard();
                  setState(() {
                    currentIndex = widget.deck.cardQuantity - 1;
                  });
                  _updateCardText();
                },
              ),
            ],
          )
        ],
      ),
      ///// BODY /////
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 4 * vh, horizontal: 6 * vw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1 * vh),
              child: Text(
                'Question:',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: tailwindGray100),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(2 * vh),
                color: tailwindGray100,
                // https://stackoverflow.com/questions/54972928/how-to-expand-a-textfield-in-flutter-looks-like-a-text-area
                child: TextField(
                  controller: _questionInputController,
                  maxLines: null,
                  decoration: null,
                  keyboardType: TextInputType
                      .text, // needed this for the 'Done' button to appear, idk why
                  onChanged: (String input) {
                    cards[currentIndex].question = input;
                  },
                  // keyboardType: TextInputType.multiline,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 1 * vh, top: 2 * vh),
              child: Text(
                'Answer:',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: tailwindGray100),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(2 * vh),
                color: tailwindGray100,
                child: TextField(
                  controller: _answerInputController,
                  maxLines: null,
                  decoration: null,
                  keyboardType: TextInputType.text,
                  onChanged: (String input) {
                    cards[currentIndex].answer = input;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Use when the user moves to another card so the question and answer of the new card are displayed
  _updateCardText() {
    _questionInputController.text = cards[currentIndex].question;
    _answerInputController.text = cards[currentIndex].answer;
  }
}
