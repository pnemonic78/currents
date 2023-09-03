import 'package:currentsapi_app/my/my_route.dart';
import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_favorites/favorites/favorites_ext.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:currentsapi_settings/settings/settings_arguments.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsController extends GetxController {
  final _userController = Get.find<UserController>();

  Rx<UserPreferences> get user => _userController.user;

  Article? article;

  void onArticlePressed(Article article) {
    _showNews(article);
  }

  void _showNews(Article article) {
    Get.toNamed(
      MyAppRoute.NewsArticle,
      arguments: NewsArguments(article),
    );
  }

  void onSettingsPressed() {
    _showSettings();
  }

  void _showSettings() {
    Get.toNamed(
      MyAppRoute.Settings,
      arguments: SettingsArguments(routeProfile: MyAppRoute.Profile),
    );
  }

  void onSearchPressed() {
    _showSearch();
  }

  void _showSearch() {
    Get.toNamed(MyAppRoute.Search);
  }

  void onFavoritesPressed() {
    _showFavorites();
  }

  void _showFavorites() {
    Get.toNamed(MyAppRoute.Favorites);
  }

  void onFavoritePressed() {
    final article = this.article;
    if (article != null) {
      _toggleFavorite(article);
    }
  }

  void _toggleFavorite(Article article) async {
    final UserPreferences user = this.user.value.copy();
    user.toggleFavorite(article);
    _userController.setUserPreferences(user);
  }

  bool isFavorite(Article article) {
    return user.value.isFavorite(article);
  }

  void onArticleSourcePressed() {
    final article = this.article;
    if (article != null) {
      _gotoArticle(article);
    }
  }

  void _gotoArticle(Article article) async {
    final urlString = article.url;
    final url = Uri.parse(urlString);
    launchUrl(url);
  }
}
