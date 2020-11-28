import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindspace/explorer/explorer.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';

import 'package:mindspace/explorer/bloc/explorer_bloc.dart';

void main() {
  initDummyData();

  runApp(
    BlocProvider(
      create: (context) => ExplorerBloc(),
      child: MaterialApp(
        title: 'Material App',
        home: Explorer(currentFolderId: 0),
        // theme: ThemeData.dark(),
        theme: ThemeData.light().copyWith(
          dividerTheme:
              DividerThemeData(space: 1, thickness: 1, color: tailwindGray500),
        ),
      ),
    ),
  );
}
