class Language {
  final String id;
  final String name;

  static const english = "en";

  Language({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    return (other is Language) && (id == other.id);
  }
}
