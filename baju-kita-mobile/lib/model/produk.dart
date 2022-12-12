class Produk {
  final String name;
  final int price;
  final String bahan;
  final int stok;
  final int kategoriId;
  final String image;

  Produk({
    required this.name,
    required this.price,
    required this.bahan,
    required this.stok,
    required this.kategoriId,
    required this.image,
  });

  factory Produk.fromJson(Map<String, dynamic> map) {
    return Produk(
      name: map['name'],
      price: map['price'],
      bahan: map['bahan'],
      stok: map['stok'],
      kategoriId: map['kategori_id'],
      image: map['image'],
    );
  }
}
