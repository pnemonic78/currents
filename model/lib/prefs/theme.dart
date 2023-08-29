import 'package:json_annotation/json_annotation.dart';

enum AppThemeMode {
  @JsonValue("system")
  system,
  @JsonValue("light")
  light,
  @JsonValue("dark")
  dark,
}
