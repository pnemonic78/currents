import 'package:currentsapi_app/my/my_route.dart';
import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_favorites/favorites/favorites_ext.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final _userController = Get.find<UserController>();

  Rx<UserPreferences> get user => _userController.user;

  void onArticlePressed(Article article) {
    _showNews(article);
  }

  void _showNews(Article article) {
    Get.toNamed(
      MyAppRoute.NewsArticle,
      arguments: NewsArguments(article),
    );
  }

  void onFavoritePressed(Article article) {
    _toggleFavorite(article);
  }

  void _toggleFavorite(Article article) async {
    final UserPreferences user = this.user.value.copy();
    user.toggleFavorite(article);
    _userController.setUserPreferences(user);
  }
}
