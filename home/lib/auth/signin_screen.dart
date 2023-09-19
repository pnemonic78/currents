import 'package:currentsapi_core/auth/firebase.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class UserSignInScreen extends StatelessWidget {
  const UserSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: FirebaseHelper.providers,
    );
  }
}
