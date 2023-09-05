import 'package:json_annotation/json_annotation.dart';

import 'status.dart';

part 'languages_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class LanguagesResponse {
  @JsonKey(name: "status")
  final Status status;
  @JsonKey(name: "languages")
  final Map<String, String> languages;

  LanguagesResponse({
    this.status = Status.ok,
    this.languages = const {},
  });

  static LanguagesResponse fromJson(Map<String, dynamic> json) =>
      _$LanguagesResponseFromJson(json);
}
