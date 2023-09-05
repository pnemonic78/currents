import 'dart:convert';
import 'dart:io';

import 'package:currentsapi_model/api/language.dart';
import 'package:currentsapi_model/api/languages.dart';
import 'package:currentsapi_model/api/status.dart';
import 'package:flutter_test/flutter_test.dart';

// `flutter test`
void main() {
  test('Example news languages', () {
    final file = File('assets/languages.json').readAsStringSync();
    final json = jsonDecode(file);
    final response = Languages.fromJson(json);

    expect(response.status, Status.ok);

    final List<Language> languages = response.languages;
    expect(23, languages.length);

    expect(languages[0].id, "ar");
    expect(languages[0].name, "Arabic");

    expect(languages.any((region) => region.id == "en"), true,
        reason: "English");
    expect(languages.any((region) => region.id == "tr"), true,
        reason: "Turkish");
    expect(languages.any((region) => region.id == "zh"), true,
        reason: "Chinese");
  });
}
