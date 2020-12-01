import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

import 'package:mindspace/definitions/colors.dart';

class FormBody extends StatelessWidget {
  // cambiar a un solo value changed que reciba enum de login
  final ValueChanged<bool> onEmailLoginTap;
  final ValueChanged<bool> onGoogleLoginTap;

  FormBody({
    Key key,
    @required this.onEmailLoginTap,
    @required this.onGoogleLoginTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height / 100;
    final double vw = MediaQuery.of(context).size.width / 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///// LOGO & APP NAME /////
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/images/mindspace_blue_bg.png",
            // height: 192,
            // width: 192,
            height: 23*vh,
            width: 23*vh,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 1*vh),
        Text(
          "Mindspace",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: tailwindGray100,
            shadows: [
              Shadow(
                color: tailwindGray900.withOpacity(0.5),
                offset: Offset(1, 2),
                blurRadius: 3.0,
              ),
            ],
          ),
        ),
        SizedBox(height: 4*vh),
        ///// EMAIL LOGIN /////
        // TODO: implement email login
        // Row(
        //   children: [
        //     Expanded(
        //       child: Divider(
        //         color: Colors.black,
        //         endIndent: 0,
        //         indent: 8,
        //       ),
        //     ),
        //     Container(
        //       margin: EdgeInsets.symmetric(horizontal: 32),
        //       child: Text(
        //         "Acceso con correo.",
        //         style: TextStyle(
        //           fontSize: 12,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: Divider(
        //         color: Colors.black,
        //         endIndent: 8,
        //         indent: 0,
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Expanded(
        //       child: Container(
        //         height: 40,
        //         margin: EdgeInsets.symmetric(horizontal: 32),
        //         child: RaisedButton(
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(18.0),
        //           ),
        //           onPressed: () => onEmailLoginTap(true),
        //           color: Colors.black,
        //           child: Row(
        //             children: [
        //               Icon(
        //                 FontAwesomeIcons.mailBulk,
        //                 color: Colors.grey[200],
        //               ),
        //               SizedBox(width: 14),
        //               Expanded(
        //                 child: Text(
        //                   "Iniciar con correo",
        //                   style: TextStyle(
        //                     color: Colors.grey[200],
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 24),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Expanded(
                child: GoogleSignInButton(
                  onPressed: () => onGoogleLoginTap(true),
                  text: "Enter with Google",
                  borderRadius: 32.0,
                  darkMode: false,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4*vh),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "Legal stuff applies.",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 10),
          ),
        ),
        // SizedBox(height: 24),
      ],
    );
  }
}
