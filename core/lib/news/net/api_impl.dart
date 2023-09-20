import 'package:currentsapi_core/data/repo.dart';
import 'package:currentsapi_core/news/net/rest_client.dart';
import 'package:currentsapi_model/api/categories_response.dart';
import 'package:currentsapi_model/api/languages.dart';
import 'package:currentsapi_model/api/news_response.dart';
import 'package:currentsapi_model/api/regions.dart';
import 'package:currentsapi_model/api/search_request.dart';

import 'api.dart';

class CurrentsApiImpl extends CurrentsApi {
  final CurrentsRepository _repo;
  final RestClient _client;

  CurrentsApiImpl(this._client, this._repo);

  Future<String> get _apiKey async => (await _repo.getConfiguration()).apiKey;

  @override
  Future<NewsResponse> latest(String languageCode) async {
    final apiKey = await _apiKey;
    return _client.getLatest(
      apiKey: apiKey,
      language: languageCode,
    );
  }

  @override
  Future<CategoriesResponse> categories() async {
    final apiKey = await _apiKey;
    return _client.getAvailableCategories(apiKey: apiKey);
  }

  @override
  Future<Languages> languages() async {
    final apiKey = await _apiKey;
    final response = await _client.getAvailableLanguages(apiKey: apiKey);
    return Languages.fromResponse(response);
  }

  @override
  Future<Regions> regions() async {
    final apiKey = await _apiKey;
    final response = await _client.getAvailableRegions(apiKey: apiKey);
    return Regions.fromResponse(response);
  }

  @override
  Future<NewsResponse> search(SearchRequest request) async {
    final apiKey = await _apiKey;
    return _client.getSearch(
      apiKey: apiKey,
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
