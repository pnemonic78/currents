import 'package:currentsapi_core/data/repo_simple.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:flutter/material.dart';

import 'news_list.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({super.key, this.onTap});

  final ValueChanged<Article>? onTap;

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  final _repo = CurrentsRepositorySimple();
  UserPreferences _userPreferences = UserPreferences();
  bool _refreshed = true;

  @override
  void initState() {
    super.initState();

    _repo
        .getUserPreferences()
        .then((prefs) => setState(() => _userPreferences = prefs));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: StreamBuilder<NewsCollection>(
        stream: _repo.getLatestNewsForUser(
          _userPreferences,
          refresh: _refreshed,
        ),
        builder: (context, snapshot) {
          _refreshed = false;

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  snapshot.error.toString(),
                  style:
                      textTheme.bodyLarge?.copyWith(color: colorScheme.error),
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;
          return NewsList(
            news: data.news,
            onTap: widget.onTap,
          );
        },
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _refreshed = true;
    });
  }
}
