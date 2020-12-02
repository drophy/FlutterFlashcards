import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mindspace/login/login_page.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';
import 'package:mindspace/models/card_object.dart';
import 'package:mindspace/models/deck_object.dart';
import 'package:mindspace/models/folder_object.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:mindspace/explorer/bloc/explorer_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Hive
  final _localStorage = await path_provider.getApplicationDocumentsDirectory(); // reference to local storage
  Hive.init(_localStorage.path); // give Hive a home directory to initialize it

  Hive.registerAdapter(FolderAdapter());
  Hive.registerAdapter(CardAdapter());
  Hive.registerAdapter(DeckAdapter());

  // Initialize Data
  Box idBox = await Hive.openBox('idBox'); // has properties/keys nextFolderId and nextDeckId
  Box idFolderBox = await Hive.openBox('idFolderBox'); // maps the id of a folder to its FolderObject
  Box idDeckBox = await Hive.openBox('idDeckBox'); // maps the id of a deck to its DeckObject

  // Handle first-time initialization
  if(idBox.get('nextFolderId') == null) {
    // TODO: see if Firebase doesn't have data already for this user
    print('FIRST TIME INITIALIZATION');

    // Create folder with Id 0
    FolderObject rootFolder = FolderObject(id: 0, name: 'Root', parentName: 'Mindspace');
    idFolderBox.put(0, rootFolder);

    // Init nextFolderId and nextDeckId
    idBox.put('nextFolderId', 1); // since id 0 was just used
    idBox.put('nextDeckId', 0);
  } else print('DBUG: nextFolderId is ${idBox.get('nextFolderId')}');
  print('INITIALIZATION COMPLETE');

  // Run App
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
