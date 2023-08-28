import 'package:currentsapi_core/news/net/api.dart';
import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/api/status.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';

import 'repo.dart';

/// Remote repository for Currents API service.
class CurrentsRepositoryRemote extends CurrentsRepository {
  final CurrentsApi _api;

  CurrentsRepositoryRemote(this._api);

  @override
  Future<UserPreferences> getUserPreferences() {
    throw UnimplementedError();
  }

  @override
  Future<void> setUserPreferences(UserPreferences? userPreferences) {
    throw UnimplementedError();
  }

  @override
  Stream<NewsCollection> getLatestNews(
    String languageCode, {
    bool refresh = true,
  }) async* {
    final response = await _api.latest(languageCode);
    final List<Article> news =
        (response.status == Status.ok) ? response.news : const [];
    yield NewsCollection(news: news);
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) {
    throw UnimplementedError();
  }
}
