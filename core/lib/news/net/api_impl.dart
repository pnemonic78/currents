import 'package:currentsapi_core/auth/keys.dart';
import 'package:currentsapi_core/news/net/rest_client.dart';
import 'package:currentsapi_model/api/categories_response.dart';
import 'package:currentsapi_model/api/languages.dart';
import 'package:currentsapi_model/api/news_response.dart';
import 'package:currentsapi_model/api/regions.dart';
import 'package:currentsapi_model/api/search_request.dart';

import 'api.dart';

class CurrentsApiImpl extends CurrentsApi {
  static const _apiKey = Keys.CURRENTS_API;

  final RestClient _client;

  // @factoryMethod
  CurrentsApiImpl(this._client);

  @override
  Future<NewsResponse> latest(String languageCode) async {
    return _client.getLatest(
      apiKey: _apiKey,
      language: languageCode,
    );
  }

  @override
  Future<CategoriesResponse> categories() async {
    return _client.getAvailableCategories(apiKey: _apiKey);
  }

  @override
  Future<Languages> languages() async {
    final response = await _client.getAvailableLanguages(apiKey: _apiKey);
    return Languages.fromResponse(response);
  }

  @override
  Future<Regions> regions() async {
    final response = await _client.getAvailableRegions(apiKey: _apiKey);
    return Regions.fromResponse(response);
  }

  @override
  Future<NewsResponse> search(SearchRequest request) {
    return _client.getSearch(
      apiKey: _apiKey,
      language: request.language,
      startDate: _formatDate(request.startDate),
      endDate: _formatDate(request.endDate),
      type: request.type,
      country: request.country,
      category: request.category,
      domain: request.domain,
      domainNot: request.domainNot,
      keywords: request.keywords,
      pageNumber: request.pageNumber,
      pageSize: request.pageSize,
      limit: request.limit,
    );
  }

  String? _formatDate(DateTime? date) => date?.toIso8601String();
}
