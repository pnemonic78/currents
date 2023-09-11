import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/net/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'latest_news_controller.dart';
import 'news_list.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({
    super.key,
    this.language,
    this.onArticlePressed,
  });

  final String? language;
  final ValueChanged<Article>? onArticlePressed;

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  final _controller = Get.put<LatestNewsController>(LatestNewsController());
  bool _refreshed = true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: StreamBuilder<TikalResult<NewsCollection>>(
        stream: _controller.getLatestNews(
          language: widget.language,
          refresh: _refreshed,
        ),
        builder: (context, snapshot) {
          _refreshed = false;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildWaiting();
          }
          if (snapshot.hasError) {
            return _buildError(context, snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return _buildWaiting();
          }

          final data = snapshot.requireData;
          if (data is TikalResultLoading) {
            return _buildWaiting();
          }
          if (data is TikalResultError) {
            return _buildError(context, (data as TikalResultError).message);
          }

          return NewsList(
            news: (data as TikalResultSuccess<NewsCollection>).data?.news ?? [],
            onArticlePressed: widget.onArticlePressed,
          );
        },
      ),
    );
  }

  Widget _buildWaiting() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(BuildContext context, String message) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "An error occurred!",
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.error),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _refreshed = true;
    });
  }
}
