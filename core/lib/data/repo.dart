import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/config_doc.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/net/result.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';

/// Repository for Currents API service.
abstract class CurrentsRepository {
  Future<UserPreferences> getUserPreferences();

  /// @param userPreferences The user preferences. `null` value deletes the profile.
  Future<void> setUserPreferences(UserPreferences? userPreferences);

  Stream<TikalResult<NewsCollection>> getLatestNews(
    String languageCode, {
    bool refresh = false,
  });

  Stream<TikalResult<NewsCollection>> getLatestNewsForUser(
    UserPreferences userPreferences, {
    bool refresh = false,
  }) {
    return getLatestNews(userPreferences.language, refresh: refresh);
  }

  Future<void> setLatestNews(NewsCollection news, String languageCode);

  Future<void> setLatestNewsForUser(
      NewsCollection news, UserPreferences userPreferences) {
    return setLatestNews(news, userPreferences.language);
  }

  Future<ConfigurationDocument> getConfiguration({bool refresh = false});

  Future<void> setConfiguration(ConfigurationDocument config);

  Stream<TikalResult<NewsCollection>> getSearch(
    SearchRequest request, {
    bool refresh = false,
  });

  Future<void> setSearch(NewsCollection? result);
}
