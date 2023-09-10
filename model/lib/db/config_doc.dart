import 'package:currentsapi_model/api/language.dart' as cal;
import 'package:currentsapi_model/api/region.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_doc.g.dart';

@JsonSerializable(explicitToJson: true)
class ConfigurationDocument {
  @JsonKey(name: "apiKey")
  String apiKey = "";
  @JsonKey(name: "categories")
  List<String> categories = [];
  @JsonKey(name: "languages")
  List<String> languages = [];
  @JsonKey(name: "regions")
  List<String> regions = [];
  @JsonKey(name: "timestamp")
  DateTime timestamp = DateTime.now();

  ConfigurationDocument({
    this.categories = const [],
    this.languages = const [cal.Language.english],
    this.regions = const [Region.regionInternational],
  });

  @override
  String toString() {
    return "{categories:$categories, languages:$languages, regions:$regions, timestamp:$timestamp}";
  }

  static ConfigurationDocument fromJson(Map<String, dynamic> json) =>
      _$ConfigurationDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationDocumentToJson(this);

  static ConfigurationDocument empty() => ConfigurationDocument(categories: []);
}
