import 'package:currentsapi_core/data/repo_simple.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:flutter/material.dart';

import 'news_list.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({super.key, this.onTap});

  final ValueChanged<Article>? onTap;

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  List<Article> _news = [];
  final _repo = CurrentsRepositorySimple();

  @override
  void initState() {
    super.initState();

    _repo.getUserPreferences().then((prefs) => _fetchNews(prefs));
  }

  void _fetchNews(UserPreferences prefs) async {
    _repo.getLatestNewsForUser(prefs).then((value) =>
        setState(() {
          _news = value.news;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Latest News"),
      ),
      body: NewsList(
        news: _news,
        onTap: widget.onTap,
      ),
    );
  }
}
