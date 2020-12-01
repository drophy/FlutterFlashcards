// Constants related to online services

import 'package:google_sign_in/google_sign_in.dart';

// This is used in the UserAuthProvider class - I made it global so I could also access it from Explorer to log out
// Note: might want to make an instance of the UserAuthProvider class global instead of just this bit, not sure
final GoogleSignIn globalGoogleSignIn = GoogleSignIn(scopes: <String>['email']);