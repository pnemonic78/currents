import 'package:currentsapi_model/api/categories_response.dart';
import 'package:currentsapi_model/api/content_type.dart';
import 'package:currentsapi_model/api/language.dart';
import 'package:currentsapi_model/api/languages_response.dart';
import 'package:currentsapi_model/api/news_response.dart';
import 'package:currentsapi_model/api/region.dart';
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
    @Query("language") String language = Language.english,
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

  /// This endpoint allow you to search through ten millions of article over 14,000 large and small news sources and blogs.
  /// This includes breaking news, blog articles, forum content.
  /// This endpoint is well suited for article discovery and analysis, but can be used to retrieve articles for display, too.
  @GET("/search")
  Future<NewsResponse> getSearch({
    @Query("apiKey") required String apiKey,
    // Valid value : Supported code can be found from /v1/available/languages
    @Query("language") String language = Language.english,
    // Search news after the given date
    // Valid format : Date format should be YYYY-MM-ddTHH:mm:ss.ss±hh:mm, which follows the offcial standard of RFC 3339 Date and Time on the Internet
    @Query("start_date") String? startDate,
    // Search news before the given date
    // Valid format : Date format should be YYYY-MM-ddTHH:mm:ss.ss±hh:mm, which follows the offcial standard of RFC 3339 Date and Time on the Internet
    @Query("end_date") String? endDate,
    // Valid format : 1 for news, 2 for article and 3 for discussion content. All 3 types are choosen if there's no specification
    @Query("type") int type = SearchContentType.news,
    // a country code representing news came from a region.
    // Valid value : Supported value can be found in /v1/available/regions
    @Query("country") String country = Region.regionInternational,
    // category which the news belongs to
    // Valid value : Supported value can be found in /v1/available/categories
    @Query("category") String? category,
    // Filter results by website domain
    // Valid format : website primary domain name (without www or blog prefix)
    @Query("domain") String? domain,
    // Remove website domain from results, allow you to blacklist any website from your search results
    // Valid format : website primary domain name (without www or blog prefix)
    @Query("domain_not") String? domainNot,
    // Exact match of words in can be found in title or description.
    @Query("keywords") String? keywords,
    // page number to access older news from current search results
    // Valid format : Any integer number larger than zero
    @Query("page_number") int pageNumber = 1,
    // Number of articles in each page
    // Valid format : Any integer between 1 to 200
    @Query("page_size") int pageSize = 30,
    // Total number of articles return in results. Try set this parameter to a small number ( around 30 ) if you have complex query
    // Valid format : Any integer between 1 to 200
    @Query("limit") int limit = 30,
  });
}
