import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindspace/login/login_page.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';

import 'package:mindspace/explorer/bloc/explorer_bloc.dart';

void main() async {
  initDummyData();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    BlocProvider(
      create: (context) => ExplorerBloc(),
      child: MaterialApp(
        title: 'Material App',
        home: LoginPage(),
        // theme: ThemeData.dark(),
        theme: ThemeData.light().copyWith(
          dividerTheme:
              DividerThemeData(space: 1, thickness: 1, color: tailwindGray500),
        ),
      ),
    ),
  );
}
