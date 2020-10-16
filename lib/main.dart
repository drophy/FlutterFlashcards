import 'package:flutter/material.dart';
import 'package:mindspace/explorer/explorer.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';

void main() {
  initDummyData();

  runApp(
    MaterialApp(
      title: 'Material App',
      home: Explorer(currentFolderId: 0),
      // theme: ThemeData.dark(),
      theme: ThemeData.light().copyWith(
        dividerTheme: DividerThemeData(
          space: 1,
          thickness: 1,
          color: tailwindGray500
        )
      )
    ),
  );
}