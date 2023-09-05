import 'language.dart';
import 'languages_response.dart';
import 'status.dart';

class Languages {
  final Status status;
  final List<Language> languages;

  Languages({
    this.status = Status.ok,
    this.languages = const [],
  });

  static Languages fromResponse(LanguagesResponse response) => Languages(
        status: response.status,
        languages: response.languages.entries
            .map(
              (MapEntry<String, String> e) => Language(id: e.value, name: e.key),
            )
            .toList(),
      );

  static Languages fromJson(Map<String, dynamic> json) =>
      fromResponse(LanguagesResponse.fromJson(json));
}
