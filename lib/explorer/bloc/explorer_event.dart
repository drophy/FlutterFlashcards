part of 'explorer_bloc.dart';

abstract class ExplorerEvent extends Equatable {
  const ExplorerEvent();

  @override
  List<Object> get props => [];
}

class UpdateEvent extends ExplorerEvent {}

class PickImageEvent extends ExplorerEvent {
  final FolderObject folder;

  PickImageEvent(this.folder);

  @override
  List<Object> get props => [folder];
}