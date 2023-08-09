import 'package:json_annotation/json_annotation.dart';

import 'news.dart';
import 'status.dart';

part 'news_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class NewsResponse {
  @JsonKey(name: "status")
  final Status status;
  @JsonKey(name: "news")
  final List<News> news;

  NewsResponse({
    this.status = Status.ok,
    this.news = const [],
  });

  static NewsResponse? fromJson(Map<String, dynamic>? json) =>
      (json == null) ? null : _$NewsResponseFromJson(json);
}
