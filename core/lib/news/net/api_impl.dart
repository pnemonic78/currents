import 'package:currentsapi_core/auth/keys.dart';
import 'package:currentsapi_core/news/net/rest_client.dart';
import 'package:currentsapi_model/api/news_response.dart';

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
}
