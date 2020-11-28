import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/editor/editor.dart';
import 'package:mindspace/explorer/bloc/explorer_bloc.dart';
import 'package:mindspace/models/card_object.dart';
import 'package:mindspace/models/deck_object.dart';

class OverviewItem extends StatefulWidget {
  final DeckObject deck;
  final int cardIndex;
  OverviewItem({Key key, @required this.deck, @required this.cardIndex})
      : super(key: key);

  @override
  _OverviewItemState createState() => _OverviewItemState();
}

class _OverviewItemState extends State<OverviewItem> {
  CardObject card;

  @override
  Widget build(BuildContext context) {
    final ExplorerBloc _bloc = BlocProvider.of<ExplorerBloc>(context);
    card = widget.deck.cards[widget.cardIndex];
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                Editor(deck: widget.deck, initialIndex: widget.cardIndex),
          ),
        );
      },
      child: Container(
          height: 12 * vh,
          child: Row(
            children: [
              // GROUP COLOR
              Expanded(
                flex: 2,
                child: Container(color: groupColors[card.group]),
              ),
              // TRASHCAN BUTTON
              Expanded(
                  flex: 14,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: warningColor,
                    ),
                    onPressed: () {
                      widget.deck.removeCard(widget.cardIndex);
                      _bloc.add(UpdateEvent());
                    },
                  )
                  // child: Checkbox(
                  //   value: card.selected,
                  //   onChanged: (bool newValue) {
                  //     setState(() {
                  //       card.selected = newValue;
                  //     });
                  //   },
                  // ),
                  ),
              Container(
                width: 1,
                color: tailwindGray500,
              ),
              // QUESTION
              Expanded(
                flex: 42,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      card.question,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: tailwindGray100),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                color: tailwindGray500,
              ),
              // ANSWER
              Expanded(
                flex: 42,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      card.answer,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: tailwindGray100),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
