import 'package:currentsapi_model/api/news.dart';
import 'package:currentsapi_model/intl/intl_utils.dart';
import 'package:currentsapi_model/prefs/theme.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_prefs.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPreferences {
  @JsonKey(name: "language")
  String language = getPlatformLanguage();
  @JsonKey(name: "theme")
  AppThemeMode theme = AppThemeMode.system;
  @JsonKey(name: "favorites")
  List<Article> favorites = [];

  String? displayName;
  String? photoURL;

  static UserPreferences fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

  UserPreferences copy(
      {String? language, AppThemeMode? theme, List<Article>? favorites}) {
    return UserPreferences()
      ..language = language ?? this.language
      ..theme = theme ?? this.theme
      ..favorites = favorites ?? this.favorites
      ..displayName = this.displayName
      ..photoURL = this.photoURL;
  }
}
