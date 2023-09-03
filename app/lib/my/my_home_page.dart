import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_settings/settings/settings_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'my_route.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _userController = Get.find<UserController>();
  bool _gotoBusy = false;

  @override
  void initState() {
    super.initState();
    _applyPreferences();
    _userController.listenSignedIn(_onSignedInChanged);

    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.
    FlutterNativeSplash.remove();
  }

  void _gotoNews() async {
    Get.offAllNamed(MyAppRoute.LatestNews);
  }

  void _gotoSignIn() async {
    Get.offAllNamed(MyAppRoute.SignIn);
  }

  void _applyPreferences() async {
    final repo = Get.find<CurrentsRepository>();
    final prefs = await repo.getUserPreferences();
    applyTheme(prefs.theme);
  }

  void _onSignedInChanged(bool isSignedIn) {
    if (_gotoBusy) return;
    _gotoBusy = true;
    if (isSignedIn) {
      _gotoNews();
    } else {
      _gotoSignIn();
    }
    _gotoBusy = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_gotoBusy) {
      Future.microtask(
        () => _userController.isSignedIn.value ? _gotoNews() : _gotoSignIn(),
      );
    }
    return Container(color: Theme.of(context).colorScheme.background);
  }
}
