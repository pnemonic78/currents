import 'dart:convert';
import 'dart:io';

import 'package:currentsapi_model/api/region.dart';
import 'package:currentsapi_model/api/regions.dart';
import 'package:currentsapi_model/api/status.dart';
import 'package:flutter_test/flutter_test.dart';

// `flutter test`
void main() {
  test('Example news regions', () {
    final file = File('assets/regions.json').readAsStringSync();
    final json = jsonDecode(file);
    final response = Regions.fromJson(json);

    expect(response.status, Status.ok);

    final List<Region> regions = response.regions;
    expect(79, regions.length);

    expect(regions[0].id, "US");
    expect(regions[0].name, "United State");

    expect(regions.any((region) => region.id == "ASIA"), true, reason: "Asia");
    expect(regions.any((region) => region.id == "EU"), true, reason: "Europe");
    expect(regions.any((region) => region.id == "INT"), true, reason: "International");
  });
}
