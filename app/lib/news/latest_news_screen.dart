import 'package:currentsapi_app/news/news_controller.dart';
import 'package:currentsapi_news/news/latest_news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({super.key});

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  final _controller = Get.put<NewsController>(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Latest News"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _controller.onSearchPressed,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: _controller.onFavoritesPressed,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _controller.onSettingsPressed,
          ),
        ],
      ),
      body: LatestNews(onArticlePressed: _controller.onArticlePressed),
    );
  }
}
