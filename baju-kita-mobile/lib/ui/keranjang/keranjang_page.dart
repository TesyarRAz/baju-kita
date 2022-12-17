import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/transaksi.dart';
import 'package:bajukita/repository/keranjang_repository.dart';
import 'package:bajukita/repository/transaksi_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/quantity_input.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final _dataListenable = ValueNotifier<List<DetailTransaksi>?>(null);
  final _totalPriceListenable = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

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
        extendBody: true,
        body: ValueListenableBuilder<List<DetailTransaksi>?>(
          valueListenable: _dataListenable,
          builder: (context, list, snapshot) {
            if (list != null) {
              if (list.isEmpty) {
                return const Center(
                  child: Text(
                    'Anda belum berbelanja',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var data = list[index];

                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Routes.detailproduk,
                              arguments: data.produk,
                            );
                          },
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: data.produk!.image,
                                          height: 80,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.produk!.name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: 'Rp. ',
                                                  decimalDigits: 0,
                                                ).format(data.produk!.price),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: QuantityInput(
                                                  minValue: 1,
                                                  type: QuantityInputType.int,
                                                  acceptsNegatives: false,
                                                  acceptsZero: false,
                                                  buttonColor: Colors.black,
                                                  iconColor: Colors.white,
                                                  value: data.qty,
                                                  onChanged: (value) {
                                                    int? qty =
                                                        int.tryParse(value);

                                                    setState(() {
                                                      data.qty =
                                                          qty ?? data.qty;
                                                      data.totalPrice = data
                                                              .qty *
                                                          (data.produk?.price ??
                                                              0);
                                                    });

                                                    KeranjangRepository()
                                                        .update(data.produkId,
                                                            data.qty);

                                                    _calculateTotalHarga();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Pertanyaan'),
                                            content: const Text(
                                              'Yakin ingin dihapus?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  KeranjangRepository()
                                                      .delete(data.produkId)
                                                      .then((value) {
                                                    Navigator.of(context).pop();
                                                    _fetchData(true);
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
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Harga',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: _totalPriceListenable,
                          builder: (context, value, child) {
                            return Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp. ',
                                decimalDigits: 0,
                              ).format(value),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: ValueListenableBuilder<List<DetailTransaksi>?>(
          valueListenable: _dataListenable,
          builder: (context, value, child) {
            if (value == null || value.isEmpty) {
              return Container();
            }
            return FloatingActionButton.extended(
              backgroundColor: Colors.black,
              icon: const Icon(Icons.shopping_cart_checkout),
              label: const Text(
                'Checkout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      contentPadding: EdgeInsets.zero,
                      children: [
                        TextButton(
                          child: const Text('Ambil ditempat'),
                          onPressed: () {
                            TransaksiRepository().checkoutDitempat().then(
                              (value) {
                                Navigator.of(context).pushNamed(
                                  Routes.detailtransaksi,
                                  arguments: value,
                                );
                              },
                            );
                          },
                        ),
                        TextButton(
                          child: const Text('Diantarkan'),
                          onPressed: () {
                            TransaksiRepository().checkoutDiantarkan().then(
                              (value) {
                                Navigator.of(context).pushNamed(
                                  Routes.checkout,
                                  arguments: value,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
                // Navigator.of(context).pushNamed(Routes.checkout);
              },
            );
          },
        ));
  }

  Future<void> _fetchData([bool force = false]) async {
    if (_dataListenable.value == null || force) {
      _dataListenable.value = await KeranjangRepository().list();

      _calculateTotalHarga();
    }
  }

  void _calculateTotalHarga() {
    if (_dataListenable.value?.isNotEmpty ?? false) {
      _totalPriceListenable.value = _dataListenable.value!
          .map((e) => e.totalPrice)
          .reduce((a, b) => a + b);
    }
  }
}
