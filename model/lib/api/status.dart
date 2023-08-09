import 'package:json_annotation/json_annotation.dart';

enum Status {
  @JsonValue("ok")
  ok,
  @JsonValue("error")
  error,
}
