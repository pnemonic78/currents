import 'package:json_annotation/json_annotation.dart';

import 'status.dart';

part 'categories_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class CategoriesResponse {
  @JsonKey(name: "status")
  final Status status;
  @JsonKey(name: "categories")
  final List<String> categories;

  CategoriesResponse({
    this.status = Status.ok,
    this.categories = const [],
  });

  static CategoriesResponse fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);
}
