import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';
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
  _ExplorerState(int currentFolderId) {
    this._currentFolder = idFolderMap[currentFolderId];
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
      appBar: AppBar(
        backgroundColor: tailwindGray900,
        title: Text('${this._currentFolder.parentName}'),
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
                            int newFolderId = nextFolderId++;
                            idFolderMap[newFolderId] = new FolderObject(
                              id: newFolderId,
                              name: _createNameController.text,
                              parentName: this._currentFolder.name,
                            );

                            // Add it to the current folder's folders array
                            this._currentFolder.addFolder(newFolderId);
                          } else {
                            // Add new DeckObject to map
                            int newDeckId = nextDeckId++;
                            idDeckMap[newDeckId] = new DeckObject(
                              id: newDeckId,
                              name: _createNameController.text,
                            );

                            // Add it to the current folder's folders array
                            this._currentFolder.addDeck(newDeckId);
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
                            onPressed: () {},
                          ),
                        ]);
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
                        child: Image.asset(
                          'assets/images/sinon.png',
                          fit: BoxFit.cover,
                        ),
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
                      currentDeckId:
                          this._deckIds[index - 1 - lastFolderIndex],
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
