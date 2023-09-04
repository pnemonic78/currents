import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_news/news/news_item.dart';
import 'package:flutter/material.dart';

class FavoritesItem extends StatelessWidget {
  final Article article;
  final ValueChanged<Article>? onArticlePressed;
  final ValueChanged<Article>? onFavoritePressed;

  const FavoritesItem({
    super.key,
    required this.article,
    this.onArticlePressed,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NewsItem(
          article: article,
          onPressed: onArticlePressed,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => onFavoritePressed?.call(article),
            icon: const Icon(Icons.favorite),
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
