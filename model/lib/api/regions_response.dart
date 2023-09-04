import 'package:json_annotation/json_annotation.dart';

import 'status.dart';

part 'regions_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class RegionsResponse {
  @JsonKey(name: "status")
  final Status status;
  @JsonKey(name: "regions")
  final Map<String, String> regions;

  RegionsResponse({
    this.status = Status.ok,
    this.regions = const {},
  });

  static RegionsResponse fromJson(Map<String, dynamic> json) =>
      _$RegionsResponseFromJson(json);
}
