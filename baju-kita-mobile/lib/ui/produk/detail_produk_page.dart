import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/produk.dart';
import 'package:bajukita/repository/keranjang_repository.dart';
import 'package:bajukita/repository/produk_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/quantity_input.dart';

class DetailProdukPage extends StatefulWidget {
  final Produk produk;

  const DetailProdukPage({required this.produk, Key? key}) : super(key: key);

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  int? _qtyBuy = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BAJUKITA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: const BackButton(),
        actions: [
          if (DataStatic.user?.role == 'admin')
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'hapus') {
                  showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Pertanyaan'),
                        content: const Text('Yakin ingin dihapus?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              ProdukRepository()
                                  .delete(widget.produk.id)
                                  .then((value) {
                                if (value) {
                                  Navigator.of(context).pop(true);
                                }
                              });
                            },
                            child: const Text('Ya'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Tidak'),
                          ),
                        ],
                      );
                    },
                  ).then((value) {
                    if (value ?? false) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Berhasil hapus produk'),
                          );
                        },
                      ).then((value) {
                        Navigator.of(context).pop(true);
                      });
                    }
                  });
                } else if (value == 'edit') {
                  Navigator.of(context)
                      .pushNamed(
                    Routes.adminprodukmodify,
                    arguments: widget.produk,
                  )
                      .then((value) {
                    if (value == true) {
                      Navigator.of(context).pop(true);
                    }
                  });
                }
              },
              itemBuilder: ((context) {
                return [
                  const PopupMenuItem<String>(
                    value: "hapus",
                    child: Text('Hapus'),
                  ),
                  const PopupMenuItem<String>(
                    value: "edit",
                    child: Text('Edit'),
                  ),
                ];
              }),
            ),
        ],
      ),
      extendBody: true,
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            CachedNetworkImage(
              imageUrl: widget.produk.image!,
              height: 300,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  widget.produk.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp. ',
                    decimalDigits: 0,
                  ).format(widget.produk.price),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Bahan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              widget.produk.bahan,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Stok",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              widget.produk.stok.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Kuantitas",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            QuantityInput(
                              buttonColor: Colors.white,
                              iconColor: Colors.black,
                              type: QuantityInputType.int,
                              acceptsNegatives: false,
                              minValue: 1,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              value: _qtyBuy,
                              onChanged: (v) => setState(() {
                                _qtyBuy = int.tryParse(v);
                              }),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Harga",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp. ',
                                decimalDigits: 0,
                              ).format((widget.produk.price * (_qtyBuy ?? 0))),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: DataStatic.user?.role == 'admin'
          ? null
          : Builder(builder: (context) {
              return FloatingActionButton.extended(
                backgroundColor: Colors.white,
                onPressed: () {
                  if (DataStatic.user == null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              const Text('Anda harus login terlebih dahulu'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(Routes.login);
                              },
                              child: const Text('Ya'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Tidak'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    KeranjangRepository()
                        .store(widget.produk.id, _qtyBuy ?? 1)
                        .then(
                      (value) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  const Text('Berhasil simpan ke keranjang'),
                              actions: [
                                TextButton(
                                  child: const Text('Ya'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        setState(() {
                          _qtyBuy = 1;
                        });
                      },
                    );
                  }
                },
                label: const Text(
                  'Masukan ke keranjang',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                icon: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.black,
                ),
              );
            }),
    );
  }
}
