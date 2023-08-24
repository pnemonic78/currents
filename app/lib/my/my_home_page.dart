import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_news/news/latest_news.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:currentsapi_settings/settings/settings_arguments.dart';
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

  Widget _signInScreen() {
    return Center(
      child: OutlinedButton(
        onPressed: _signIn,
        child: const Text('Sign In'),
      ),
    );
  }

  void _signIn() {
    Navigator.pushNamed(context, MyAppRoute.SignIn);
  }

  void _showNews(Article news) {
    Navigator.pushNamed(
      context,
      MyAppRoute.NewsArticle,
      arguments: NewsArguments(news),
    );
  }

  void _showSettings() {
    Navigator.pushNamed(
      context,
      MyAppRoute.Settings,
      arguments: SettingsArguments(routeProfile: MyAppRoute.Profile),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettings,
          )
        ],
      ),
      body: (FirebaseAuth.instance.currentUser == null)
          ? _signInScreen()
          : LatestNews(onTap: _showNews),
    );
  }
}
