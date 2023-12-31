import 'package:currentsapi_model/api/news.dart';
import 'package:flutter/material.dart';

import 'favorites_item.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({
    super.key,
    required this.news,
    this.onArticlePressed,
    this.onFavoritePressed,
  });

  final List<Article> news;
  final ValueChanged<Article>? onArticlePressed;
  final ValueChanged<Article>? onFavoritePressed;

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  late ScrollController _scrollController;

  _FavoritesListState();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void _onArticleTap(Article news) {
    widget.onArticlePressed?.call(news);
  }

  void _onFavoriteTap(Article news) {
    widget.onFavoritePressed?.call(news);
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    if (news.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text("No favorites"),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) => FavoritesItem(
        article: news[index],
        onArticlePressed: _onArticleTap,
        onFavoritePressed: _onFavoriteTap,
      ),
      itemCount: news.length,
    );
  }
}
