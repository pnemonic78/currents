class Category {
  final String id;
  final String name;

  Category({
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
    return (other is Category) && (id == other.id);
  }
}
