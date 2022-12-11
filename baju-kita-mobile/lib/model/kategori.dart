class Kategori {
  final String name;

  Kategori({
    required this.name,
  });

  factory Kategori.fromJson(Map<String, dynamic> map) {
    return Kategori(
      name: map['name'],
    );
  }
}
