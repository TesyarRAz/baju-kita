class Kategori {
  final int id;
  final String name;

  Kategori({
    required this.id,
    required this.name,
  });

  factory Kategori.fromJson(Map<String, dynamic> map) {
    return Kategori(
      id: map['id'],
      name: map['name'],
    );
  }
}
