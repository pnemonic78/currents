import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/config_doc.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';

import 'repo.dart';

class CurrentRepositoryImpl extends CurrentsRepository {
  final CurrentsRepository _local;
  final CurrentsRepository _remote;

  CurrentRepositoryImpl(this._local, this._remote);

  static const _oldAgeNewsMinutes = 5;
  static const _oldAgeConfigurationDays = 7;

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
    if (refresh || (diff.inMinutes >= _oldAgeNewsMinutes)) {
      try {
        final remoteNews = await _remote.getLatestNews(languageCode).first;
        _local.setLatestNews(remoteNews, languageCode);
        yield remoteNews;
      } on Exception catch (e) {
        print("getLatestNews Exception $e");
        // use local
      }
    }

    yield* localNews;
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) async {
    return _local.setLatestNews(news, languageCode);
  }

  @override
  Future<ConfigurationDocument> getConfiguration({bool refresh = false}) async {
    final localConfiguration = await _local.getConfiguration(refresh: refresh);

    // if news is older than X minutes, then fetch from remote server.
    final diff = DateTime.now().difference(localConfiguration.timestamp);
    if (refresh || (diff.inDays >= _oldAgeConfigurationDays)) {
      try {
        final remoteConfiguration = await _remote.getConfiguration()
          ..apiKey = localConfiguration.apiKey;
        _local.setConfiguration(remoteConfiguration);
        return remoteConfiguration;
      } on Exception catch (e) {
        print("getConfiguration Exception $e");
        // use local
      }
    }

    return localConfiguration;
  }

  @override
  Future<void> setConfiguration(ConfigurationDocument config) async {
    return _local.setConfiguration(config);
  }

  @override
  Stream<NewsCollection> getSearch(
    SearchRequest request, {
    bool refresh = false,
  }) async* {
    final localNews = _local.getSearch(request).asBroadcastStream();
    final localNewsSnapshot = await localNews.first;
    yield localNewsSnapshot;

    // if results are older than X minutes, then fetch from remote server.
    final diff = DateTime.now().difference(localNewsSnapshot.timestamp);
    if (refresh || (diff.inMinutes >= _oldAgeNewsMinutes)) {
      try {
        final remoteNews = await _remote.getSearch(request).first;
        _local.setSearch(remoteNews);
        yield remoteNews;
      } on Exception catch (e) {
        print("getSearch Exception $e");
        // use local
      }
    }

    yield* localNews;
    yield* _local.getSearch(request);
  }

  @override
  Future<void> setSearch(NewsCollection? result) async {
    return _local.setSearch(result);
  }
}
