import 'package:currentsapi_app/my/my_route.dart';
import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_favorites/favorites/favorites_ext.dart';
import 'package:currentsapi_model/api/category.dart' as cac;
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:currentsapi_settings/settings/settings_arguments.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsController extends GetxController {
  final _userController = Get.find<UserController>();
  final _repo = Get.find<CurrentsRepository>();

  Rx<UserPreferences> get user => _userController.user;

  final RxList<String> categories = (const <String>[]).obs;

  @override
  void onInit() async {
    final config = await _repo.getConfiguration();
    categories.value = config.categories;
    super.onInit();
  }

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

  void onFavoritePressed(Article article) {
    _toggleFavorite(article);
  }

  void _toggleFavorite(Article article) async {
    final UserPreferences user = this.user.value.copy();
    user.toggleFavorite(article);
    _userController.setUserPreferences(user);
  }

  bool isFavorite(Article article) {
    return user.value.isFavorite(article);
  }

  void onArticleSourcePressed(Article article) {
    _gotoArticle(article);
  }

  void _gotoArticle(Article article) async {
    final urlString = article.url;
    final url = Uri.parse(urlString);
    launchUrl(url);
  }

  void onArticleCategoryPressed(Article article, String category) {
    _filterCategory(article.language, category);
  }

  void onCategoryPressed(cac.Category category) {
    final String language = user.value.language;
    _filterCategory(language, category.id);
  }

  void _filterCategory(String language, String category) async {
    Get.toNamed(
      MyAppRoute.SearchResults,
      arguments: SearchRequest(
        language: language,
        category: category,
      ),
    );
  }
}
