import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindspace/models/folder_object.dart';

part 'explorer_event.dart';
part 'explorer_state.dart';

//! Implemented this as a Global Bloc, so it can be reached lit anywhere
//? probs not ideal; we'd probably want a provider per Explorer, not sure
class ExplorerBloc extends Bloc<ExplorerEvent, ExplorerState> {
  ExplorerBloc() : super(ExplorerInitial());

  @override
  Stream<ExplorerState> mapEventToState(
    ExplorerEvent event,
  ) async* {
    if (event is UpdateEvent) {
      print('BLOC: UPDATE EVENT'); // DBUG
      yield UpdateState(); // so it detects a change of state and rebuilds the UI
      yield ExplorerInitial(); // while actually staying on the same state
    } else if (event is PickImageEvent) {
      File image = await _chooseImage(event.fromGallery);
      if(image == null) return;
      
      List<int> imageBytes = await image.readAsBytes();
      event.folder.base64image = base64Encode(imageBytes);
      event.folder.save();

      // TODO: replace the following for a ImageChangedState or something (think that will be more efficient, but this works for now)
      // TODO: then make just the folder_object listen to it (it needs a bloc and find how to make the other blocs ignore it)
      yield UpdateState(); // Rebuild UI
      yield ExplorerInitial();
    }
  }
}

///// METHODS /////
Future<File> _chooseImage(bool fromGallery) async {
  final picker = ImagePicker();
  final PickedFile chooseImage = await picker.getImage(
    source: fromGallery? ImageSource.gallery : ImageSource.camera,
    preferredCameraDevice: CameraDevice.rear,
    maxHeight: 1920,
    maxWidth: 1920,
    imageQuality: 100,
  );
  return File(chooseImage.path);
}
