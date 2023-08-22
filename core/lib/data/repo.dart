import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';

/// Repository for Currents API service.
abstract class CurrentsRepository {
  Future<UserPreferences> getUserPreferences();

  Future<void> setUserPreferences(UserPreferences userPreferences);

  Future<NewsCollection> getLatestNews(String languageCode);

  Future<NewsCollection> getLatestNewsForUser(UserPreferences userPreferences) {
    return getLatestNews(userPreferences.language);
  }

  Future<void> setLatestNews(NewsCollection news, String languageCode);

  Future<void> setLatestNewsForUser(NewsCollection news, UserPreferences userPreferences) {
    return setLatestNews(news, userPreferences.language);
  }
}
