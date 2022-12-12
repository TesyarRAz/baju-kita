import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/produk.dart';
import 'package:bajukita/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class DetailProdukPage extends StatefulWidget {
  final Produk produk;

  const DetailProdukPage({required this.produk, Key? key}) : super(key: key);

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
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
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            CachedNetworkImage(
              imageUrl: widget.produk.image,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            if (DataStatic.user == null) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('Anda harus login terlebih dahulu'),
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
              showDialog(
                context: context,
                builder: (context) {
                  return const SimpleDialog(
                    title: Text('Kuantitas'),
                    contentPadding: EdgeInsets.all(10),
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          // border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  );
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
