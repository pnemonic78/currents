class Region {
  final String id;
  final String name;

  static const String regionEurope = "EU";
  static const String regionAsia = "ASIA";
  static const String regionInternational = "INT";
  static const String regionAll = "";

  Region({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }
}
