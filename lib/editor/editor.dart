import 'package:flutter/material.dart';
import 'package:mindspace/definitions/colors.dart';

class Editor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      backgroundColor: tailwindGray700,
      appBar: AppBar(
        backgroundColor: tailwindGray900,
        title: Text('Editor'),
        actions: [
          Row(
            children: [
              IconButton(
                color: tailwindGray100,
                disabledColor: tailwindGray700,
                icon: Icon(Icons.arrow_back),
                onPressed: 3 > 5? null : () {

                },
              ),
              Text(
                '3/5',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: tailwindGray100),
              ),
              IconButton(
                color: tailwindGray100,
                disabledColor: tailwindGray700,
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  print('next card');
                },
              ),
            ],
          )
        ],
      ),
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
                color: tailwindGray100,
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
                color: tailwindGray100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
