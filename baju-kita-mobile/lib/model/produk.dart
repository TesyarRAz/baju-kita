class Produk {
  final String name;
  final int price;
  final String description;
  final int kategoriId;
  final String image;

  Produk({
    required this.name,
    required this.price,
    required this.description,
    required this.kategoriId,
    required this.image,
  });

  factory Produk.fromJson(Map<String, dynamic> map) {
    return Produk(
      name: map['name'],
      price: map['price'],
      description: map['description'],
      kategoriId: map['kategori_id'],
      image: map['image'],
    );
  }
}
