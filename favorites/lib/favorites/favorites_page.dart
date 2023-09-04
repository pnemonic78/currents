import 'package:currentsapi_model/api/news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'favorites_controller.dart';
import 'favorites_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
    this.onArticlePressed,
    this.onFavoritePressed,
  });

  final ValueChanged<Article>? onArticlePressed;
  final ValueChanged<Article>? onFavoritePressed;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _controller =
      Get.put<FavoritesPageController>(FavoritesPageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    final news = _controller.favorites;

    if (news.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text("No favorites"),
        ),
      );
    }

    return FavoritesList(
      news: news,
      onArticlePressed: widget.onArticlePressed,
      onFavoritePressed: widget.onFavoritePressed,
    );
  }
}
