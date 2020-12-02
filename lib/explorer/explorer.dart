import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mindspace/auth/user_auth_provider.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';
import 'package:mindspace/definitions/online.dart';
import 'package:mindspace/explorer/bloc/explorer_bloc.dart';
import 'package:mindspace/explorer/folder.dart';
import 'package:mindspace/explorer/deck.dart';
import 'package:mindspace/models/folder_object.dart';
import 'package:mindspace/models/deck_object.dart';

class Explorer extends StatefulWidget {
  final int currentFolderId;
  Explorer({Key key, @required this.currentFolderId}) : super(key: key);

  @override
  _ExplorerState createState() => _ExplorerState(currentFolderId);
}

class _ExplorerState extends State<Explorer> {
  FolderObject _currentFolder;
  List<int> _folderIds;
  List<int> _deckIds;
  Box _idBox;
  Box _idFolderBox;
  Box _idDeckBox;

  // I sent the id as an argument forgetting we could get it as simply widget.currentFolderId >w<
  _ExplorerState(int currentFolderId) {
    this._idBox = Hive.box('idBox');
    this._idFolderBox = Hive.box('idFolderBox');
    this._idDeckBox = Hive.box('idDeckBox');
    this._currentFolder = this._idFolderBox.get(currentFolderId);
    this._folderIds = this._currentFolder.folders;
    this._deckIds = this._currentFolder.decks;
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;
    final _createNameController = TextEditingController();

    return Scaffold(
      backgroundColor: tailwindGray700,
      ///// APP BAR /////
      appBar: AppBar(
        backgroundColor: tailwindGray900,
        title: Text('${this._currentFolder.parentName}'),
        automaticallyImplyLeading: false,
        leading: widget.currentFolderId == 0? null : BackButton(onPressed: () {
          Navigator.maybePop(
              context); // not sure of how it's different to pop(), but it says 'leading' uses this by default
        }),
        actions: [
          IconButton(
            color: tailwindGray100,
            disabledColor: tailwindGray700,
            icon: Icon(Icons.content_paste),
            onPressed: null,
          ),
          // New Folder/Set
          PopupMenuButton(
            child: Icon(Icons.add),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(child: Text('Folder'), value: 'Folder'),
              PopupMenuItem(child: Text('Card Deck'), value: 'Deck'),
            ],
            onSelected: (result) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('$result name:'),
                  content: TextField(
                      controller: _createNameController,
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
                      child: Text('CREATE'),
                      onPressed: () {
                        setState(() {
                          if (result == 'Folder') {
                            // Add new FolderObject to map
                            int newFolderId = _idBox.get('nextFolderId');
                            _idBox.put('nextFolderId', newFolderId + 1);
                            FolderObject newFolder = new FolderObject(
                              id: newFolderId,
                              name: _createNameController.text,
                              parentName: this._currentFolder.name,
                            );
                            _idFolderBox.put(newFolderId, newFolder);

                            // Add it to the current folder's folders array
                            _currentFolder.addFolder(newFolderId);
                          } else {
                            // Add new DeckObject to map
                            int newDeckId = _idBox.get('nextDeckId');
                            _idBox.put('nextDeckId', newDeckId + 1);
                            DeckObject newDeck = new DeckObject(
                              id: newDeckId,
                              name: _createNameController.text,
                            );
                            _idDeckBox.put(newDeckId, newDeck);

                            // Add it to the current folder's folders array
                            _currentFolder.addDeck(newDeckId);
                          }
                        });
                        Navigator.of(context).pop(); // close pop up
                      },
                    )
                  ],
                ),
              );
            },
          ),
          IconButton(
            color: tailwindGray100,
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    backgroundColor: tailwindGray100,
                    title: Text('Sign out?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Yes'),
                        onPressed: () {
                          // TODO: Log out and return to Login page
                          globalGoogleSignIn.signOut();
                          print('ABOUT TO POP DIALOG');
                          Navigator.of(context)
                              .pop('pop again'); // close dialog
                        },
                      ),
                    ],
                  );
                },
              ).then((value) {
                // TODO: we might not need this .then() after all
                if (value == 'pop again') {
                  print('ABOUT TO POP ${_currentFolder.name}');
                  Navigator.of(context).pop('pop again'); // exit page
                }
              });
            },
          )
        ],
      ),
      body: BlocBuilder<ExplorerBloc, ExplorerState>(
        builder: (context, state) {
          return Column(children: [
            ///// FOLDER DETAILS /////
            Row(
              children: [
                // IMAGE
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      // color: Colors.red, // dbug
                      height: 150,
                      width: 150,
                      padding: EdgeInsets.all(16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _currentFolder.detailsImage(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${this._currentFolder.name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: tailwindGray100),
                        ),
                        SizedBox(height: 1 * vh),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            minHeight: 1 * vh,
                            backgroundColor: tailwindGray100,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(progressColor1),
                          ),
                        ),
                        SizedBox(height: 1 * vh),
                        Text(
                          '70% Subject Mastery',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: tailwindGray100),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ///// FOLDERS AND CARD SETS /////
            Expanded(
              child: ListView.separated(
                itemCount: this._folderIds.length +
                    this._deckIds.length +
                    2, // we'll add empty elements at beginning and end to add extra separators
                // idea from https://codewithandrea.com/tips/2020-01-12-list-view-separated-top-bottom/
                itemBuilder: (context, index) {
                  int lastFolderIndex = this._folderIds.length;

                  // SIZED BOXES
                  if (index == 0 ||
                      index == lastFolderIndex + this._deckIds.length + 1) {
                    return SizedBox(); // zero height: not visible
                  }

                  // FOLDERS
                  else if (index <= lastFolderIndex) {
                    return Folder(
                      currentFolderId: this._folderIds[index - 1],
                    ); // index-1 since i=0 is being used for a SizedBox
                  }

                  // DECKS
                  else
                    return Deck(
                      currentDeckId: this._deckIds[index - 1 - lastFolderIndex],
                    );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
