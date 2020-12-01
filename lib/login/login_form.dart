import 'package:mindspace/definitions/colors.dart';
import 'package:mindspace/explorer/explorer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'form_body.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;
  bool _showLoading = false;

  // @override
  // void dispose() {
  //   _loginBloc.close();
  //   super.dispose();
  // }

  void _emailLogIn(bool _) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (context) {
        return Container(
          padding: MediaQuery.of(context)
              .viewInsets, // mostrar contenido sobre el teclado
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(),
                SizedBox(height: 14),
                TextField(),
                SizedBox(height: 24),
                MaterialButton(
                  onPressed: () {},
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _googleLogIn(bool _) {
    // invocar al login de firebase con el bloc
    // recodar configurar pantallad Oauth en google Cloud
    print("google");
    _loginBloc.add(LoginWithGoogleEvent());
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

    return Stack(
      children: [
        // Stack background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                tailwindGray700,
                tailwindGray900,
              ],
            ),
          ),
        ),
        // Form content
        SafeArea(
          child: BlocProvider(
            create: (context) {
              _loginBloc = LoginBloc();
              return _loginBloc..add(VerifyLogInEvent());
            },
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginErrorState) {
                  _showLoading = false;
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text("${state.error}"),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          )
                        ],
                      );
                    },
                  );
                } else if (state is LoginLoadingState) {
                  _showLoading = !_showLoading;
                } else if (state is LoginSuccessState) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Explorer(currentFolderId: 0),
                    ),
                  );
                }
              },
              builder: (context, state) {
                // Changed this so it's a different page instead
                // if (state is LoginSuccessState) {
                // _showLoading =
                //     false; // drophy - the radial progress indicator kept showing, so this is a quick patch
                // return Explorer(currentFolderId: 0);
                // }
                //! the Container below was inside a SingleChildScrollView, probs for when we had the email/password inputs
                return Container(
                  // margin: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
                  margin: EdgeInsets.symmetric(vertical: 8*vh, horizontal: 5*vw),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xA0FFFFFF),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0 * vh),
                    child: FormBody(
                      onGoogleLoginTap: _googleLogIn,
                      onEmailLoginTap: _emailLogIn,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _showLoading ? CircularProgressIndicator() : Container(),
        ),
      ],
    );
  }
}
