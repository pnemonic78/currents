import 'package:currentsapi_app/my/my_route.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_news/news/latest_news.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:currentsapi_settings/settings/settings_arguments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({super.key});

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Latest News"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearch,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: _showFavorites,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: LatestNews(onTap: _showNews),
    );
  }

  void _showNews(Article article) {
    Get.toNamed(
      MyAppRoute.NewsArticle,
      arguments: NewsArguments(article),
    );
  }

  void _showSettings() {
    Get.toNamed(
      MyAppRoute.Settings,
      arguments: SettingsArguments(routeProfile: MyAppRoute.Profile),
    );
  }

  void _showSearch() {
    Get.toNamed(MyAppRoute.Search);
  }

  void _showFavorites() {
    Get.toNamed(MyAppRoute.Favorites);
  }
}
