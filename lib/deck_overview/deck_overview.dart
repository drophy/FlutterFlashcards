import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';
import 'package:mindspace/editor/editor.dart';
import 'package:mindspace/models/deck_object.dart';

import 'overview_item.dart';

class DeckOverview extends StatefulWidget {
  final int deckId;
  DeckOverview({Key key, @required this.deckId}) : super(key: key);

  @override
  _DeckOverviewState createState() => _DeckOverviewState();
}

class _DeckOverviewState extends State<DeckOverview> {
  DeckObject deck;
  List<int> filteredCardIndexes = [];

  @override
  void initState() {
    deck = idDeckMap[widget.deckId];
    _filterCards('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Deck overview'),
        backgroundColor: tailwindGray900,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              deck.addCard();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      Editor(deck: deck, initialIndex: deck.cards.length - 1),
                ),
              );
            },
          )
        ],
      ),
      backgroundColor: tailwindGray700,
      body: Stack(children: [
        Column(
          children: [
            // TODO: try and align the hintText with the icon (baseline?) and maybe with the appBar's text, not sure
            TextField(
              onSubmitted: _filterCards,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: filteredCardIndexes.length + 1,
                itemBuilder: (context, index) {
                  if (index == filteredCardIndexes.length) return SizedBox();
                  return OverviewItem(
                    deck: deck,
                    cardIndex: filteredCardIndexes[index],
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
          ],
        ),
        // The idea was to have checkboxes on each and delete them from here, but it's on top of the last element
        // and I'm sure it will be much more impractical than just adding delete buttons instead of checkboxes
        // Positioned(
        //   bottom: 0,
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: 3*vh, horizontal: 8*vw),
        //     width: 100*vw,
        //     height: 100,
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: tailwindGray100,
        //         borderRadius: BorderRadius.circular(8),
        //         boxShadow: [BoxShadow(
        //           blurRadius: 2,
        //           spreadRadius: 0.5,
        //         )],
        //       ),
        //     ),
        //   ),
        // )
      ]),
    );
  }

  void _filterCards(String input) {
    setState(() {
      filteredCardIndexes.clear();
      String inputLC = input.toLowerCase();
      for (int i = 0; i < deck.cards.length; i++) {
        String question = deck.cards[i].question.toLowerCase();
        String answer = deck.cards[i].answer.toLowerCase();
        if (inputLC == '' ||
            question.contains(inputLC) ||
            answer.contains(inputLC)) {
          filteredCardIndexes.add(i);
        }
      }
    });
    print(filteredCardIndexes);
  }
}
