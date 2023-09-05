import 'package:currentsapi_model/api/region.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filters_db.g.dart';

@JsonSerializable(explicitToJson: true)
class FiltersCollection {
  @JsonKey(name: "categories")
  List<String> categories = [];
  @JsonKey(name: "languages")
  List<String> languages = [];
  @JsonKey(name: "regions")
  List<String> regions = [];
  @JsonKey(name: "timestamp")
  DateTime timestamp = DateTime.now();

  FiltersCollection({
    this.categories = const [],
    this.languages = const ["en"],
    this.regions = const [Region.regionInternational],
  });

  @override
  String toString() {
    return "{categories:$categories, languages:$languages, regions:$regions, timestamp:$timestamp}";
  }

  static FiltersCollection fromJson(Map<String, dynamic> json) =>
      _$FiltersCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersCollectionToJson(this);

  static FiltersCollection empty() => FiltersCollection(categories: []);
}
