import 'package:currentsapi_model/intl/intl_utils.dart';
import 'package:currentsapi_model/prefs/theme.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_prefs.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPreferences {
  @JsonKey(name: "favorites")
  List<String> favorites = [];
  @JsonKey(name: "language")
  String language = getPlatformLanguage();
  @JsonKey(name: "theme")
  AppTheme theme = AppTheme.system;

  String? displayName;
  String? photoURL;

  static UserPreferences fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
