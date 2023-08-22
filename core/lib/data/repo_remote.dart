import 'package:currentsapi_core/news/net/api.dart';
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
  Future<void> setUserPreferences(UserPreferences userPreferences) {
    throw UnimplementedError();
  }

  @override
  Future<NewsCollection> getLatestNews(String languageCode) async {
    final response = await _api.latest(languageCode);
    if (response.status == Status.ok) {
      return NewsCollection(news: response.news);
    }
    return NewsCollection(news: const []);
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) {
    throw UnimplementedError();
  }
}
