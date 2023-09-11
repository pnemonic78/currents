import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/net/result.dart';
import 'package:currentsapi_news/news/news_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_controller.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({
    super.key,
    required this.request,
    this.onArticlePressed,
  });

  final SearchRequest request;
  final ValueChanged<Article>? onArticlePressed;

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final _controller = Get.isRegistered<SearchFormController>()
      ? Get.find<SearchFormController>()
      : Get.put<SearchFormController>(SearchFormController());
  bool _refreshed = true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: StreamBuilder<TikalResult<NewsCollection>>(
        stream: _controller.getSearchResults(
          request: widget.request,
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
