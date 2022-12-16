import 'package:bajukita/model/transaksi.dart';
import 'package:bajukita/repository/transaksi_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({Key? key}) : super(key: key);

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final _dataListenable = ValueNotifier<List<Transaksi>?>(null);

  @override
  void initState() {
    super.initState();

    _fetch();
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
      ),
      body: ValueListenableBuilder<List<Transaksi>?>(
        valueListenable: _dataListenable,
        builder: (context, list, child) {
          if (list == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

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

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              var data = list[index];

              return Card(
                child: InkWell(
                  onTap: () {
                    if (data.type == 'diantarkan' && data.status == 'request') {
                      Navigator.of(context).pushNamed(
                        Routes.checkout,
                        arguments: data,
                      );
                      return;
                    }

                    Navigator.of(context).pushNamed(
                      Routes.detailtransaksi,
                      arguments: data,
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.invoiceCode,
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
                                  ).format(data.totalPrice),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  data.type == 'ambil_ditempat'
                                      ? 'Ambil Ditempat'
                                      : 'Diantarkan',
                                )
                              ],
                            ),
                            Chip(
                              label: Text(
                                StringUtils.capitalize(data.status),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      Column(
                          children: data.detailTransaksis!.map(
                        (e) {
                          return ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: e.produk!.image,
                            ),
                            title: Text(e.produk!.name),
                            subtitle: Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp. ',
                                decimalDigits: 0,
                              ).format(e.produk!.price),
                            ),
                            trailing: Text(
                              e.qty.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ).toList()),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _fetch([bool force = false]) async {
    if (_dataListenable.value == null || force) {
      _dataListenable.value = await TransaksiRepository().list();
    }
  }
}
