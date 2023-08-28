import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'my_route.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.
    FlutterNativeSplash.remove();
  }

  void _showNews(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MyAppRoute.LatestNews,
      (route) => false,
    );
  }

  void _showSignIn(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MyAppRoute.SignIn,
      (route) => false,
    );
  }

  void _showHome(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      _showNews(context);
    } else {
      _showSignIn(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => _showHome(context));
    return Container(color: Theme.of(context).colorScheme.background);
  }
}
