import 'package:currentsapi_core/auth/keys.dart';
import 'package:currentsapi_core/news/net/rest_client.dart';
import 'package:currentsapi_model/api/status.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// `flutter test`
void main() {
  test('Latest news', () async {
    const language = "en";
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    final client = RestClient(dio);
    final response = await client.getLatest(
      apiKey: Keys.CURRENTS_API,
      language: language,
    );
    print('±!@ response=[$response]');

    expect(response.status, Status.ok);

    final news = response.news;
    expect(news.isNotEmpty, true);

    final article = news[0];
    expect(article.id.isNotEmpty, true);
    expect(article.title.isNotEmpty, true);
    expect(article.author?.isNotEmpty, true);
    expect(article.image?.isNotEmpty, true);
    expect(article.language, language);
    expect(article.category.isNotEmpty, true);

    final now = DateTime.now();
    expect(now.year, article.published.year);
    expect(now.month, article.published.month);
    expect(now.day, article.published.day);
  });
}
