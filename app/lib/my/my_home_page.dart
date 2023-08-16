import 'dart:convert';

import 'package:currentsapi_app/news/news_arguments.dart';
import 'package:currentsapi_app/news/news_list.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/api/news_response.dart';
import 'package:currentsapi_model/api/status.dart';
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
  List<News> _news = [];

  @override
  void initState() {
    super.initState();

    _parseNews();

    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.
    FlutterNativeSplash.remove();
  }

  void _parseNews() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/latest-news.json');
    final json = jsonDecode(data);
    final response = NewsResponse.fromJson(json);
    if (response?.status == Status.ok) {
      setState(() {
        _news = response!.news;
      });
    }
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

  void _showNews(News news) {
    Navigator.pushNamed(context, MyAppRoute.NewsArticle,
        arguments: NewsArguments(news));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: (FirebaseAuth.instance.currentUser == null)
          ? _signInScreen()
          : NewsList(
              news: _news,
              onTap: _showNews,
            ),
    );
  }
}
