import 'package:currentsapi_favorites/favorites/favorites_page.dart';
import 'package:currentsapi_home/favorites/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _controller = Get.put<FavoritesController>(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Favorites"),
      ),
      body: FavoritesPage(
        onArticlePressed: _controller.onArticlePressed,
        onFavoritePressed: _controller.onFavoritePressed,
      ),
    );
  }
}
