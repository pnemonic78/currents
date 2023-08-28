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
  Future<void> setUserPreferences(UserPreferences? userPreferences) async {
    return _local.setUserPreferences(userPreferences);
  }

  @override
  Stream<NewsCollection> getLatestNews(
    String languageCode, {
    bool refresh = false,
  }) async* {
    final localNews = _local
        .getLatestNews(languageCode, refresh: refresh)
        .asBroadcastStream();
    final localNewsSnapshot = await localNews.first;
    yield localNewsSnapshot;

    // if news is older than X minutes, then fetch from remote server.
    final diff = DateTime.now().difference(localNewsSnapshot.timestamp);
    if (refresh || (diff.inMinutes >= _oldAgeMinutes)) {
      final remoteNews = await _remote.getLatestNews(languageCode).first;
      _local.setLatestNews(remoteNews, languageCode);
      yield remoteNews;
    }

    yield* localNews;
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) async {
    return _local.setLatestNews(news, languageCode);
  }
}
