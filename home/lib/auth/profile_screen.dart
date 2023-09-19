import 'package:currentsapi_core/auth/firebase.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      providers: FirebaseHelper.providers,
    );
  }
}
