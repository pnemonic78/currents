import 'dart:convert';

import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/api/news_response.dart';
import 'package:currentsapi_model/api/status.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_db.g.dart';

@JsonSerializable(explicitToJson: true)
class NewsCollection {
  @JsonKey(name: "news")
  List<Article> news = [];
  @JsonKey(name: "timestamp")
  DateTime timestamp = DateTime.now();

  NewsCollection({required this.news});

  static NewsCollection fromJson(Map<String, dynamic> json) =>
      _$NewsCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$NewsCollectionToJson(this);

  @override
  String toString() {
    return news.toString();
  }

  static NewsCollection empty() => NewsCollection(news: []);

  static Future<List<Article>> parseLatestNews() async {
    final data = await rootBundle
        .loadString('packages/currentsapi_model/assets/latest-news.json');
    final json = jsonDecode(data);
    final response = NewsResponse.fromJson(json);
    if (response.status == Status.ok) {
      return response.news;
    }
    return [];
  }
}
