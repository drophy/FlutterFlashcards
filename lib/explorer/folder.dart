import 'package:flutter/material.dart';

import 'package:mindspace/explorer/explorer.dart';

import 'package:mindspace/models/folder_object.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';

class Folder extends StatelessWidget {
  final int currentFolderId;
  Folder({Key key, @required this.currentFolderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FolderObject _currentFolder = idFolderMap[this.currentFolderId];
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

    return FlatButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Explorer(currentFolderId: this.currentFolderId)));
      },
      child: Container(
        height: 12 * vh,
        // color: Colors.amber[300],
        child: Row(
          children: [
            // FOLDER NAME
            Expanded(
              flex: 85,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4 * vh),
                child: Row(
                  children: [
                    Icon(
                      Icons.folder,
                      color: tailwindGray100,
                    ),
                    SizedBox(width: 4 * vw),
                    Expanded(
                      child: Text(
                        _currentFolder.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: tailwindGray100),
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // MORE OPTIONS
            Expanded(
              flex: 15,
              child: Center(
                // TODO: Add actions (rename, add image, copy, delete, share, move up, move down #oof)
                child: PopupMenuButton(
                  child: Icon(
                    Icons.more_vert,
                    color: tailwindGray100,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(child: Text('Rename'), value: 'rename'),
                    PopupMenuItem(child: Text('Add image'), value: 'image'),
                  ],
                  onSelected: (result) {
                    if (result == 'rename') {
                      _currentFolder.name = 'Hello';
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void _renameFolderHandler(BuildContext context, FolderObject folder) {
  //   final _newNameController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Folder name:'),
  //       content: TextField(
  //           controller: _newNameController,
  //           decoration: InputDecoration(
  //             // labelText: 'New Folder',
  //             filled: true,
  //           )),
  //       actions: [
  //         FlatButton(
  //           child: Text('CANCEL'),
  //           onPressed: () => Navigator.of(context).pop(),
  //         ),
  //         RaisedButton(
  //           child: Text('SAVE'),
  //           onPressed: () {
  //             setState(() {
  //               folder.name = _newNameController.text;
  //             });
  //             Navigator.of(context).pop(); // close pop up
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
}
