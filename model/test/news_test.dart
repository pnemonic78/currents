import 'dart:convert';
import 'dart:io';

import 'package:currentsapi_model/api/news_response.dart';
import 'package:currentsapi_model/api/status.dart';
import 'package:flutter_test/flutter_test.dart';

// `flutter test`
void main() {
  test('Example news', () {
    final file = File('assets/latest-news.json').readAsStringSync();
    final json = jsonDecode(file);
    final response = NewsResponse.fromJson(json);

    expect(response.status, Status.ok);

    final news = response.news;
    expect(5, news.length);

    final article = news[0];
    expect(article.id, "e1749cf0-8a49-4729-88b2-e5b4d03464ce");
    expect(article.title, "US House speaker Nancy Pelosi backs congressional legislation on Hong Kong");
    expect(article.author, "Robert Delaney");
    expect(article.image, "None");
    expect(article.language, "en");
    expect(article.category[0], "world");

    expect(2019, article.published.year);
    expect(DateTime.september, article.published.month);
    expect(18, article.published.day);
    expect(21, article.published.hour);
    expect(8, article.published.minute);
    expect(58, article.published.second);
  });
}
