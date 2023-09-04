import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Region {
  final String id;
  final String name;

  Region({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }
}
