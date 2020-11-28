part of 'explorer_bloc.dart';

abstract class ExplorerState extends Equatable {
  const ExplorerState();
  
  @override
  List<Object> get props => [];
}

class ExplorerInitial extends ExplorerState {}

class UpdateState extends ExplorerState {}