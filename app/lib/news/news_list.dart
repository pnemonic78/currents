import 'package:currentsapi_app/news/news_item.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:flutter/material.dart';

class NewsList extends StatefulWidget {
  const NewsList({
    super.key,
    required this.news,
    this.onTap,
  });

  final List<Article> news;
  final ValueChanged<Article>? onTap;

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late ScrollController _scrollController;

  _NewsListState();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void _onTap(Article news) {
    widget.onTap?.call(news);
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    if (news.isEmpty) {
      return const Center(
        child: Text("No news"),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) => NewsItem(
        article: news[index],
        onTap: _onTap,
      ),
      itemCount: news.length,
    );
  }
}
