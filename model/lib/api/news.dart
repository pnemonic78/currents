import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class News {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "author")
  final String? author;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "language")
  final String language;
  @JsonKey(name: "category")
  final List<String> category;
  @JsonKey(name: "published")
  final DateTime published;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    this.author,
    this.image,
    this.language = "en",
    this.category = const [],
    required this.published,
  });

  static News? fromJson(Map<String, dynamic>? json) =>
      (json == null) ? null : _$NewsFromJson(json);
}