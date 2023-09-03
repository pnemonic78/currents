import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_settings/settings/settings_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'my_home_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = Get.put<MyHomeController>(MyHomeController());

  @override
  void initState() {
    super.initState();
    _applyPreferences();

    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.
    FlutterNativeSplash.remove();
  }

  void _applyPreferences() async {
    final repo = Get.find<CurrentsRepository>();
    final prefs = await repo.getUserPreferences();
    applyTheme(prefs.theme);
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => _controller.onBuild());
    return Container(color: Theme.of(context).colorScheme.background);
  }
}
