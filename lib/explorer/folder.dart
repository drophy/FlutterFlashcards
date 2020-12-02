import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mindspace/explorer/bloc/explorer_bloc.dart';

import 'package:mindspace/explorer/explorer.dart';

import 'package:mindspace/models/folder_object.dart';
import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/definitions/dummydata.dart';

class Folder extends StatefulWidget {
  final int currentFolderId;
  Folder({Key key, @required this.currentFolderId}) : super(key: key);

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  FolderObject _currentFolder;
  final _newNameController = TextEditingController();
  Box _idFolderBox;

  @override
  void initState() {
    super.initState();
    _idFolderBox = Hive.box('idFolderBox');
    _currentFolder = _idFolderBox.get(widget.currentFolderId);
    _newNameController.text = _currentFolder.name;
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                Explorer(currentFolderId: this.widget.currentFolderId),
          ),
        ).then((value) {
          if(value == 'pop again') {
            print('ABOUT TO POP: ${_currentFolder.name}');
            Navigator.of(context).pop('pop again');
          }
        });
      },
      child: Container(
        height: 12 * vh,
        padding: EdgeInsets.symmetric(horizontal: 4 * vw),
        decoration: BoxDecoration(
            image: DecorationImage(
          // ty https://stackoverflow.com/questions/58427142/how-to-pass-image-asset-in-imageprovider-type
          image: Image.asset('assets/images/fitoria.png').image,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.5), BlendMode.luminosity),
        )),
        child: Row(
          children: [
            // FOLDER NAME
            Expanded(
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
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            // MORE OPTIONS
            PopupMenuButton(
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
                  setState(() {
                    _renameFolder(context);
                  });
                } else if (result == 'image') {
                  setState(() {
                    // CONTINUE - make BLOC get and change the image
                    BlocProvider.of<ExplorerBloc>(context)
                        .add(PickImageEvent(_currentFolder));
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _renameFolder(context) {
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
                _currentFolder.name = _newNameController.text;
                _currentFolder.save();
              });
              Navigator.of(context).pop(); // close pop up
            },
          )
        ],
      ),
    );
  }
}
