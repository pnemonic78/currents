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
  void _showProfile() {
    Navigator.pushNamed(context, MyAppRoute.Profile);
  }

  void _signIn() {
    Navigator.pushNamed(context, MyAppRoute.SignIn);
  }

  @override
  void initState() {
    super.initState();
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (FirebaseAuth.instance.currentUser == null)
                ? OutlinedButton(
                    onPressed: _signIn,
                    child: const Text('Sign In'),
                  )
                : OutlinedButton(
                    onPressed: _showProfile,
                    child: const Text('My Profile'),
                  ),
          ],
        ),
      ),
    );
  }
}
