import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'latest_news_controller.dart';
import 'news_list.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({super.key, this.onArticlePressed});

  final ValueChanged<Article>? onArticlePressed;

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  final _controller = Get.put<LatestNewsController>(LatestNewsController());
  bool _refreshed = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: StreamBuilder<NewsCollection>(
        stream: _controller.getLatestNewsForUser(refresh: _refreshed),
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
            onArticlePressed: widget.onArticlePressed,
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
