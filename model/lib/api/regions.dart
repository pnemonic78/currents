import 'region.dart';
import 'regions_response.dart';
import 'status.dart';

class Regions {
  final Status status;
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
