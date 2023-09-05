class Language {
  final String id;
  final String name;

  Language({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return name;
  }
}
