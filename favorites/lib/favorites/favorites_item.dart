import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_news/news/news_item.dart';
import 'package:flutter/material.dart';

class FavoritesItem extends StatelessWidget {
  final Article article;
  final ValueChanged<Article>? onArticleTap;
  final ValueChanged<Article>? onFavoriteTap;

  const FavoritesItem({
    super.key,
    required this.article,
    this.onArticleTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NewsItem(
          article: article,
          onTap: onArticleTap,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => onFavoriteTap?.call(article),
            icon: const Icon(Icons.favorite),
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
