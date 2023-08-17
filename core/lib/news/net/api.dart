import 'package:currentsapi_model/api/news_response.dart';
import 'package:flutter/widgets.dart';

abstract class CurrentsApi {

  Future<NewsResponse> latest(BuildContext context);

}