import 'package:currentsapi_app/my/my_route.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:currentsapi_settings/settings/settings_arguments.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
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
}
