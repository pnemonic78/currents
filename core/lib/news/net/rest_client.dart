import 'package:currentsapi_model/api/categories_response.dart';
import 'package:currentsapi_model/api/languages_response.dart';
import 'package:currentsapi_model/api/news_response.dart';
import 'package:currentsapi_model/api/regions_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.currentsapi.services/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // @factoryMethod
  static RestClient of(Dio dio) => RestClient(dio);

  /// An endpoint which stream the latest international news
  @GET("/latest-news")
  Future<NewsResponse> getLatest({
    @Query("apiKey") required String apiKey,
    @Query("language") required String language,
  });

  /// List of available news category
  @GET("/available/categories")
  Future<CategoriesResponse> getAvailableCategories({
    @Query("apiKey") required String apiKey,
  });

  /// List of valid language code
  @GET("/available/languages")
  Future<LanguagesResponse> getAvailableLanguages({
    @Query("apiKey") required String apiKey,
  });

  /// List of country code for query
  @GET("/available/regions")
  Future<RegionsResponse> getAvailableRegions({
    @Query("apiKey") required String apiKey,
  });
}
