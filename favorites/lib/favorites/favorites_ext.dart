import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';

extension UserFavorites on UserPreferences {
  bool isFavoriteId(String id) {
    return favorites.any((article) => article.id == id);
  }

  bool isFavorite(Article article) {
    return isFavoriteId(article.id);
  }

  void toggleFavorite(Article article) {
    isFavorite(article) ? clearFavorite(article) : markFavorite(article);
  }

  void markFavorite(Article article) {
    favorites.add(article);
  }

  void clearFavorite(Article article) {
    if (favorites.remove(article)) return;
    favorites.removeWhere((a) => a.id == article.id);
  }
}
