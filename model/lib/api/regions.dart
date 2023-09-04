import 'package:currentsapi_model/api/region.dart';
import 'package:currentsapi_model/api/regions_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'status.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class Regions {
  @JsonKey(name: "status")
  final Status status;
  @JsonKey(name: "regions")
  final List<Region> regions;

  Regions({
    this.status = Status.ok,
    this.regions = const [],
  });

  static Regions fromResponse(RegionsResponse response) => Regions(
        status: response.status,
        regions: response.regions.entries
            .map(
              (MapEntry<String, String> e) => Region(id: e.value, name: e.key),
            )
            .toList(),
      );

  static Regions fromJson(Map<String, dynamic> json) =>
      fromResponse(RegionsResponse.fromJson(json));
}
