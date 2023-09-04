import 'dart:convert';
import 'dart:io';

import 'package:currentsapi_model/api/categories_response.dart';
import 'package:currentsapi_model/api/status.dart';
import 'package:flutter_test/flutter_test.dart';

// `flutter test`
void main() {
  test('Example categories', () {
    final file = File('assets/categories.json').readAsStringSync();
    final json = jsonDecode(file);
    final response = CategoriesResponse.fromJson(json);

    expect(response.status, Status.ok);

    final categories = response.categories;
    expect(46, categories.length);

    expect(categories[0], "regional");
  });
}
