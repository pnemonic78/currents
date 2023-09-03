import 'package:currentsapi_favorites/favorites/favorites_ext.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:currentsapi_news/news/news_article.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'news_controller.dart';

class NewsArticleScreen extends StatefulWidget {
  const NewsArticleScreen({super.key});

  @override
  State<NewsArticleScreen> createState() => _NewsArticleScreenState();
}

class _NewsArticleScreenState extends State<NewsArticleScreen> {
  final _controller = Get.put<NewsController>(NewsController());

  @override
  void initState() {
    final args = Get.arguments as NewsArguments;
    _controller.article = args.news;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final article = _controller.article!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(article.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: _controller.onArticleSourcePressed,
          ),
          Obx(
            () => IconButton(
              icon: _controller.user.value.isFavorite(article)
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_outline),
              onPressed: _controller.onFavoritePressed,
            ),
          ),
        ],
      ),
      body: NewsArticlePage(article: article),
    );
  }
}
