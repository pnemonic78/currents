import 'package:currentsapi_app/my/my_route.dart';
import 'package:currentsapi_auth/user/user_controller.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:currentsapi_news/news/news_arguments.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final _userController = Get.find<UserController>();

  Rx<UserPreferences> get user => _userController.user;

  SearchRequest request = SearchRequest();

  void onSearchPressed(SearchRequest request) {
    _gotoSearchResults(request);
  }

  void _gotoSearchResults(SearchRequest request) {
    Get.toNamed(MyAppRoute.SearchResults, arguments: request);
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
}
