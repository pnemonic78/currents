import 'package:currentsapi_home/news/news_controller.dart';
import 'package:currentsapi_model/api/category.dart' as cac;
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
      body: _buildNews(context),
    );
  }

  Widget _buildNews(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Obx(() => _buildCategories(context, _controller.categories)),
        ),
        Obx(
          () => Expanded(
            child: LatestNews(
              language: _controller.user.value.language,
              onArticlePressed: _controller.onArticlePressed,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(BuildContext context, List<String> categoryCodes) {
    final List<cac.Category> categories = categoryCodes
        .map((e) => (e, _getCategoryName(context, e)))
        .where((p) => p.$2 != null)
        .map((p) => cac.Category(id: p.$1, name: p.$2!))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    final List<Widget> categoriesChips = categories
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: ActionChip(
              label: Text(e.name),
              onPressed: () => _controller.onCategoryPressed(e),
            ),
          ),
          // (e) => Text(e.name),
        )
        .toList();

    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: categoriesChips,
    );
  }

  String? _getCategoryName(BuildContext context, String categoryCode) {
    return (categoryCode.toLowerCase() == categoryCode)
        ? categoryCode.capitalize
        : categoryCode;
  }
}
