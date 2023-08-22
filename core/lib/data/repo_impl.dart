import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';

import 'repo.dart';

class CurrentRepositoryImpl extends CurrentsRepository {
  final CurrentsRepository _local;
  final CurrentsRepository _remote;

  CurrentRepositoryImpl(this._local, this._remote);

  static const _oldAgeMinutes = 5;

  @override
  Future<UserPreferences> getUserPreferences() {
    return _local.getUserPreferences();
  }

  @override
  Future<void> setUserPreferences(UserPreferences userPreferences) async {
    return _local.setUserPreferences(userPreferences);
  }

  @override
  Future<NewsCollection> getLatestNews(String languageCode) async {
    // if news is older than X minutes, then fetch from remote server.
    final localNews = await _local.getLatestNews(languageCode);
    final diff = DateTime.now().difference(localNews.timestamp);
    if (diff.inMinutes >= _oldAgeMinutes) {
      final remoteNews = await _remote.getLatestNews(languageCode);
      _local.setLatestNews(remoteNews, languageCode);
      return remoteNews;
    }
    return localNews;
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) async {
    return _local.setLatestNews(news, languageCode);
  }
}
