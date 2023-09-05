import 'package:currentsapi_model/api/news.dart';
import 'package:flutter/material.dart';

import 'news_item.dart';

class NewsList extends StatefulWidget {
  const NewsList({
    super.key,
    required this.news,
    this.onArticlePressed,
  });

  final List<Article> news;
  final ValueChanged<Article>? onArticlePressed;

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
    widget.onArticlePressed?.call(news);
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    if (news.isEmpty) {
      final size = MediaQuery.of(context).size;

      return SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text("No news"),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) => NewsItem(
        article: news[index],
        onPressed: _onTap,
      ),
      itemCount: news.length,
    );
  }
}
