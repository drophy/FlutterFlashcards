import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    if(event is UpdateEvent) {
      print('BLOC: UPDATE EVENT'); // DBUG 
      yield UpdateState(); // so it detects a change of state and rebuilds the UI
      yield ExplorerInitial(); // while actually staying on the same state
    }
  }
}
