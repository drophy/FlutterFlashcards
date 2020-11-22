import 'package:flutter/material.dart';
import 'package:mindspace/deck_overview/deck_overview.dart';

import 'package:mindspace/models/deck_object.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';
import 'package:mindspace/study_view/study_view.dart';

class Deck extends StatelessWidget {
  final int currentDeckId;
  Deck({Key key, @required this.currentDeckId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;
    DeckObject _currentDeck = idDeckMap[currentDeckId];

    return Container(
      height: 12 * vh,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4 * vw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///// NAME AND OPTIONS ICON /////
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${_currentDeck.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: tailwindGray100),
                  ),
                ),
                // TODO: add Actions (Start Studying, Edit Cards, View All Cards, Move Up, Move Down, Share, Delete)
                PopupMenuButton(
                  child: Icon(
                    Icons.more_vert,
                    color: tailwindGray100,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(child: Text('Study'), value: 'study'),
                    PopupMenuItem(child: Text('Edit Cards'), value: 'edit'),
                    PopupMenuItem(child: Text('Reset Progress'), value: 'reset'),
                  ],
                  onSelected: (result) {
                    if (result == 'edit' || result == 'study') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return result == 'edit'
                                ? DeckOverview(deckId: currentDeckId)
                                : StudyView(deck: _currentDeck);
                          },
                        ),
                      );
                    } else if (result == 'reset') {
                      _currentDeck.resetProgress();
                    }
                  },
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
                      valueColor: AlwaysStoppedAnimation(progressColor1),
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
