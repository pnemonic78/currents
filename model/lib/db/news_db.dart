import 'package:currentsapi_model/api/news.dart';
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
}
