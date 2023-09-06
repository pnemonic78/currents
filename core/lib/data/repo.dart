import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/filters_db.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';

/// Repository for Currents API service.
abstract class CurrentsRepository {
  Future<UserPreferences> getUserPreferences();

  /// @param userPreferences The user preferences. `null` value deletes the profile.
  Future<void> setUserPreferences(UserPreferences? userPreferences);

  Stream<NewsCollection> getLatestNews(
    String languageCode, {
    bool refresh = false,
  });

  Stream<NewsCollection> getLatestNewsForUser(
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

  Future<FiltersCollection> getFilters({bool refresh = false});

  Future<void> setFilters(FiltersCollection filters);

  Stream<NewsCollection> getSearch(SearchRequest request);

  Future<void> setSearch(NewsCollection? result);
}
