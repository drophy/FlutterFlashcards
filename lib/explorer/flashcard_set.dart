import 'package:flutter/material.dart';

import 'package:mindspace/models/deck_object.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';

class FlashcardSet extends StatelessWidget {
  final int currentDeckId;
  FlashcardSet({Key key, @required this.currentDeckId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;
    DeckObject _currentDeck = idDeckMap[currentDeckId];

    return Container(
      height: 12 * vh,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///// NAME AND OPTIONS ICON /////
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_currentDeck.name}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: tailwindGray100),
                ),
                // TODO: add Actions (Start Studying, Edit Cards, View All Cards, Move Up, Move Down, Share, Delete)
                Icon(
                  Icons.more_vert,
                  color: tailwindGray100,
                ),
              ],
            ),
            ///// PROGRESS AND CARD COUNT /////
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _currentDeck.progress,
                      minHeight: 1 * vh,
                      backgroundColor: tailwindGray100,
                      valueColor: AlwaysStoppedAnimation(Colors.green[200]),
                    ),
                  ),
                ),
                SizedBox(width: 4 * vw),
                Text(
                  '${_currentDeck.seenQuantity}/${_currentDeck.cardQuantity}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: tailwindGray900),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
