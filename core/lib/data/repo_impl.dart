import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/db/config_doc.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/net/result.dart';
import 'package:currentsapi_model/prefs/user_prefs.dart';
import 'package:rxdart/rxdart.dart';

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
  Stream<TikalResult<NewsCollection>> getLatestNews(
    String languageCode, {
    bool refresh = false,
  }) {
    final subject = BehaviorSubject<TikalResult<NewsCollection>>.seeded(
        TikalResultLoading());

    final localResults = _local.getLatestNews(languageCode, refresh: refresh);
    bool isFirstSuccess = true;
    localResults.forEach((e) async {
      if (isFirstSuccess) {
        if (e is TikalResultSuccess) {
          await _maybeFetchLatestNews(
            subject,
            e as TikalResultSuccess<NewsCollection>,
            languageCode: languageCode,
            refresh: refresh,
          );
          isFirstSuccess = false;
        } else {
          subject.add(e);
        }
      } else {
        subject.add(e);
      }
    });

    return subject;
  }

  Future<void> _maybeFetchLatestNews(
    BehaviorSubject<TikalResult<NewsCollection>> subject,
    TikalResultSuccess<NewsCollection> localResult, {
    required String languageCode,
    bool refresh = false,
  }) async {
    NewsCollection? data = localResult.data;
    if (data == null) return;

    // if news is older than X minutes, then fetch from remote server.
    final diff = DateTime.now().difference(data.timestamp);
    if (refresh || (diff.inMinutes >= _oldAgeNewsMinutes)) {
      subject.add(TikalResultLoading());

      try {
        final remoteResults = _remote.getLatestNews(languageCode);
        await remoteResults.forEach((e) async {
          if (e is TikalResultSuccess) {
            final remoteResult = e as TikalResultSuccess<NewsCollection>;
            final NewsCollection? remoteData = remoteResult.data;
            if (remoteData != null) {
              _local.setLatestNews(remoteData, languageCode);
            }
          }
        });
      } on Exception catch (e) {
        print("_maybeFetchLatestNews Exception $e");
        // use local
      }
    }
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
  Stream<TikalResult<NewsCollection>> getSearch(
    SearchRequest request, {
    bool refresh = false,
  }) {
    final subject = BehaviorSubject<TikalResult<NewsCollection>>.seeded(
        TikalResultLoading());

    final localResults = _local.getSearch(request);
    bool isFirstSuccess = true;
    localResults.forEach((e) async {
      if (isFirstSuccess) {
        if (e is TikalResultSuccess) {
          await _maybeFetchSearch(
            subject,
            e as TikalResultSuccess<NewsCollection>,
            request: request,
            refresh: refresh,
          );
          isFirstSuccess = false;
        } else {
          subject.add(e);
        }
      } else {
        subject.add(e);
      }
    });

    return subject;
  }

  Future<void> _maybeFetchSearch(
    BehaviorSubject<TikalResult<NewsCollection>> subject,
    TikalResultSuccess<NewsCollection> localResult, {
    required SearchRequest request,
    bool refresh = false,
  }) async {
    NewsCollection? data = localResult.data;
    if (data == null) return;

    // if results are older than X minutes, then fetch from remote server.
    final diff = DateTime.now().difference(data.timestamp);
    if (refresh || (diff.inMinutes >= _oldAgeNewsMinutes)) {
      subject.add(TikalResultLoading());

      try {
        final remoteResults = _remote.getSearch(request);
        await remoteResults.forEach((e) async {
          if (e is TikalResultSuccess) {
            final remoteResult = e as TikalResultSuccess<NewsCollection>;
            final NewsCollection? remoteData = remoteResult.data;
            if (remoteData != null) {
              _local.setSearch(remoteData);
            }
          }
        });
      } on Exception catch (e) {
        print("_maybeFetchSearch Exception $e");
        // use local
      }
    }
  }

  @override
  Future<void> setSearch(NewsCollection? result) async {
    return _local.setSearch(result);
  }
}
