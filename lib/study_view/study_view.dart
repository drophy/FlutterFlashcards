import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/explorer/bloc/explorer_bloc.dart';
import 'package:mindspace/models/card_object.dart';
import 'package:mindspace/models/deck_object.dart';

class StudyView extends StatefulWidget {
  final DeckObject deck;
  StudyView({Key key, @required this.deck}) : super(key: key);

  @override
  _StudyViewState createState() => _StudyViewState();
}

class _StudyViewState extends State<StudyView> {
  CardObject card;
  bool showingQuestion = true;

  @override
  void initState() {
    super.initState();
    widget.deck.shuffle();
    card = widget.deck.nextCard();
  }

  @override
  Widget build(BuildContext context) {
    final ExplorerBloc _bloc = BlocProvider.of<ExplorerBloc>(context);
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

    return Scaffold(
        ///// APP BAR /////
        appBar: AppBar(
          title: Text(widget.deck.name),
          backgroundColor: tailwindGray900,
          leading: BackButton(onPressed: () {
            print('IT WORKED 3');
            _bloc.add(UpdateEvent());
            Navigator.maybePop(context);
          }),
        ),
        backgroundColor: tailwindGray700,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8 * vh, horizontal: 8 * vw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                ///// CARD /////
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showingQuestion = !showingQuestion;
                    });
                  },
                  child: Container(
                    color: showingQuestion
                        ? groupColors[0]
                        : groupColors[card.group],
                    padding: EdgeInsets.symmetric(
                        vertical: 2 * vh, horizontal: 4 * vw),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2 * vh, horizontal: 4 * vw),
                      child: Center(
                        child: Text(
                          showingQuestion ? card.question : card.answer,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: tailwindGray100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2 * vh),
              ///// BOTTOM PART /////
              showingQuestion
                  ? SizedBox()
                  : Text('How well did you know this?',
                      style: TextStyle(color: tailwindGray100)),
              SizedBox(height: 1 * vh),
              _bottomBuilder(vh),
            ],
          ),
        ));
  }

  Widget _bottomBuilder(double vh) {
    if (showingQuestion) {
      return FlatButton(
        child: Container(
          width: double.infinity,
          height: 8 * vh,
          child: Center(
              child: Text('Reveal Answer', style: TextStyle(fontSize: 16))),
        ),
        color: interactColor,
        onPressed: () {
          setState(() {
            showingQuestion = false;
          });
        },
      );
    } else {
      return Container(
        height: 8 * vh,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _handleGroupSelection(1);
                },
                child: Container(
                  color: groupColors[1],
                  child: Center(
                    child: Text('1', style: TextStyle(color: tailwindGray100)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _handleGroupSelection(2);
                },
                child: Container(
                  color: groupColors[2],
                  child: Center(
                    child: Text('2', style: TextStyle(color: tailwindGray100)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _handleGroupSelection(3);
                },
                child: Container(
                  color: groupColors[3],
                  child: Center(
                    child: Text('3', style: TextStyle(color: tailwindGray100)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _handleGroupSelection(4);
                },
                child: Container(
                  color: groupColors[4],
                  child: Center(
                    child: Text('4', style: TextStyle(color: tailwindGray100)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _handleGroupSelection(5);
                },
                child: Container(
                  color: groupColors[5],
                  child: Center(
                    child: Text('5', style: TextStyle(color: tailwindGray100)),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _handleGroupSelection(int group) {
    widget.deck.recolorCard(group: group);
    setState(() {
      card = widget.deck.nextCard();
      showingQuestion = true;
    });
  }
}
