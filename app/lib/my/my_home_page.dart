import 'dart:convert';

import 'package:currentsapi_app/news/news_item.dart';
import 'package:currentsapi_model/api/news_response.dart';
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
  NewsResponse? _newsResponse;
  late ScrollController _scrollController;

  void _signIn() {
    Navigator.pushNamed(context, MyAppRoute.SignIn);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _parseNews();

    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.
    FlutterNativeSplash.remove();
  }

  void _parseNews() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/latest-news.json');
    final json = jsonDecode(data);
    final response = NewsResponse.fromJson(json)!;
    setState(() {
      _newsResponse = response;
    });
  }

  Widget _newsList() {
    final response = _newsResponse;
    if (response == null) return Container();
    final news = response.news + response.news;

    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) => NewsItem(
        news: news[index],
      ),
      itemCount: news.length,
    );
  }

  Widget _signInScreen() {
    return Center(
      child: OutlinedButton(
        onPressed: _signIn,
        child: const Text('Sign In'),
      ),
    );
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
          : _newsList(),
    );
  }
}
