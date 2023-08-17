import 'package:currentsapi_model/api/news_response.dart';
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
    @Query("apiKey")  required String apiKey,
    @Query("language") required String language,
  });
}
