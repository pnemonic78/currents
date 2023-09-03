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
  Widget build(BuildContext context) {
    final args = Get.arguments as NewsArguments;
    final article = args.news;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(article.title),
        actions: [
          Obx(() => IconButton(
                icon: _controller.user.value.isFavorite(article)
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_outline),
                onPressed: () => _controller.onFavoritePressed(article),
              )),
        ],
      ),
      body: NewsArticlePage(article: article),
    );
  }
}
