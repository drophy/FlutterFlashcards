import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindspace/auth/user_auth_provider.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserAuthProvider _authProvider = UserAuthProvider();

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is VerifyLogInEvent) {
      try {
        if (_authProvider.isAlreadyLogged())
          yield LoginSuccessState();
        else
          yield LoginInitial();
      } catch (e) {
        print(e.toString());
        yield LoginInitial();
      }
    } else if (event is LoginWithGoogleEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.signInWithGoogle();
        yield LoginSuccessState();
        // open home page widget
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(
          error: "Error al hacer login con Google: ${e.toString()}",
        );
      }
    } else if (event is LogoutFromGoogleEvent) {
      _authProvider.signOutGoogle();
    } else if (event is LoginWithEmailEvent) {
      // TODO: email login
    } else if (event is ForgotPasswordEvent) {
      // TODO: reset password workflow
    }
  }
}
