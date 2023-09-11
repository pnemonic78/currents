import 'package:currentsapi_core/news/net/api.dart';
import 'package:currentsapi_model/api/language.dart';
import 'package:currentsapi_model/api/region.dart';
import 'package:currentsapi_model/api/search_request.dart';
import 'package:currentsapi_model/api/status.dart';
import 'package:currentsapi_model/db/config_doc.dart';
import 'package:currentsapi_model/db/news_db.dart';
import 'package:currentsapi_model/net/result.dart';
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
  Stream<TikalResult<NewsCollection>> getLatestNews(
    String languageCode, {
    bool refresh = true,
  }) async* {
    yield TikalResultLoading();
    final response = await _api.latest(languageCode);
    if (response.status == Status.ok) {
      yield TikalResultSuccess(NewsCollection(news: response.news));
    } else {
      yield TikalResultError.withMessage<NewsCollection>(response.status.name);
    }
  }

  @override
  Future<void> setLatestNews(NewsCollection news, String languageCode) {
    throw UnimplementedError();
  }

  @override
  Future<ConfigurationDocument> getConfiguration({bool refresh = false}) async {
    final categoriesResponse = await _api.categories();
    final languagesResponse = await _api.languages();
    final regionsResponse = await _api.regions();

    final List<String> categories = (categoriesResponse.status == Status.ok)
        ? categoriesResponse.categories
        : const [];

    final List<String> languages = (languagesResponse.status == Status.ok)
        ? languagesResponse.languages.map((e) => e.id).toList()
        : const [Language.english];

    final List<String> regions = (regionsResponse.status == Status.ok)
        ? regionsResponse.regions.map((e) => e.id).toList()
        : const [Region.regionInternational];

    return ConfigurationDocument(
      categories: categories,
      languages: languages,
      regions: regions,
    );
  }

  @override
  Future<void> setConfiguration(ConfigurationDocument config) {
    throw UnimplementedError();
  }

  @override
  Stream<TikalResult<NewsCollection>> getSearch(
    SearchRequest request, {
    bool refresh = true,
  }) async* {
    yield TikalResultLoading();
    final response = await _api.search(request);
    if (response.status == Status.ok) {
      yield TikalResultSuccess(NewsCollection(news: response.news));
    } else {
      yield TikalResultError.withMessage<NewsCollection>(response.status.name);
    }
  }

  @override
  Future<void> setSearch(NewsCollection? result) async {
    throw UnimplementedError();
  }
}
