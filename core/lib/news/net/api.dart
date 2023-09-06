import 'package:currentsapi_model/api/categories_response.dart';
import 'package:currentsapi_model/api/languages.dart';
import 'package:currentsapi_model/api/news_response.dart';
import 'package:currentsapi_model/api/regions.dart';
import 'package:currentsapi_model/api/search_request.dart';

abstract class CurrentsApi {
  Future<NewsResponse> latest(String languageCode);

  Future<CategoriesResponse> categories();

  Future<Languages> languages();

  Future<Regions> regions();

  Future<NewsResponse> search(SearchRequest request);
}
