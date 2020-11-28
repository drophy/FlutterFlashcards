import 'package:flutter/material.dart';
import 'package:mindspace/deck_overview/deck_overview.dart';

import 'package:mindspace/models/deck_object.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';
import 'package:mindspace/study_view/study_view.dart';

class Deck extends StatefulWidget {
  final int currentDeckId;
  Deck({Key key, @required this.currentDeckId}) : super(key: key);

  @override
  _DeckState createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  final _newNameController = TextEditingController();
  DeckObject _currentDeck;
  
  @override
  void initState() {
    super.initState();
    _currentDeck = idDeckMap[widget.currentDeckId];
    _newNameController.text = _currentDeck.name;
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

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
                // TODO: add Actions (Delete, Move Up, Move Down, Share, Copy to Clipboard)
                PopupMenuButton(
                  child: Icon(
                    Icons.more_vert,
                    color: tailwindGray100,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(child: Text('Study'), value: 'study'),
                    PopupMenuItem(child: Text('Edit Cards'), value: 'edit'),
                    PopupMenuItem(child: Text('Rename Deck'), value: 'rename'),
                    PopupMenuItem(
                        child: Text('Reset Progress'), value: 'reset'),
                  ],
                  onSelected: (result) {
                    // EDIT & STUDY
                    if (result == 'study') {
                      if(_currentDeck.cardQuantity == 0) {
                        // TODO: show snackbar
                        Scaffold.of(context).showSnackBar(_simpleSnackbar('Add some cards in "Edit Cards" to start studying!'));
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudyView(deck: _currentDeck)
                        ),
                      );
                    } else if (result == 'edit') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DeckOverview(deckId: widget.currentDeckId)
                        ),
                      );
                    }
                    // RESET
                    else if (result == 'reset') {
                      _currentDeck.resetProgress();
                    }
                    // RENAME
                    else if (result == 'rename') {
                      _renameDeck(context);
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

  void _renameDeck(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Deck name:'),
        content: TextField(
            controller: _newNameController,
            decoration: InputDecoration(
              labelText: 'Name',
              filled: true,
            )),
        actions: [
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          RaisedButton(
            child: Text('RENAME'),
            onPressed: () {
              setState(() {
                _currentDeck.name = _newNameController.text;
              });
              Navigator.of(context).pop(); // close pop up
            },
          )
        ],
      ),
    );
  }

  _simpleSnackbar(String text) {
    return SnackBar(content: Text(text));
  }
}
