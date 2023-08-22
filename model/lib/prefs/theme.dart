import 'package:json_annotation/json_annotation.dart';

enum Theme {
  @JsonValue("system")
  system,
  @JsonValue("dark")
  dark,
  @JsonValue("light")
  light,
}
