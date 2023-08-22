import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {
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

  Article({
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

  static const ImageNone = "None";

  bool get isValidImage {
    return (image != null) && image!.isNotEmpty && (image != ImageNone);
  }

  static Article fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
