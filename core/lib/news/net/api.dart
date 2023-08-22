import 'package:currentsapi_model/api/news_response.dart';

abstract class CurrentsApi {

  Future<NewsResponse> latest(String languageCode);

}