import 'package:bajukita/model/transaksi.dart';
import 'package:bajukita/routes.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailTransaksiPage extends StatefulWidget {
  final Transaksi transaksi;

  const DetailTransaksiPage({required this.transaksi, Key? key})
      : super(key: key);

  @override
  State<DetailTransaksiPage> createState() => _DetailTransaksiPageState();
}

class _DetailTransaksiPageState extends State<DetailTransaksiPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Chip(
              label: Text(
                StringUtils.capitalize(widget.transaksi.status),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green,
            ),
            Text(
              'Kode Invoice',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            QrImage(
              data: widget.transaksi.invoiceCode,
              size: 200,
            ),
            Visibility(
              visible: widget.transaksi.type == 'ambil_ditempat',
              child: Text(
                'Perlihatkan ke kasir untuk mengambil barang belanja anda',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.transaksi.detailTransaksis?.length,
              itemBuilder: (context, index) {
                var data = widget.transaksi.detailTransaksis![index];

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp. ',
                      decimalDigits: 0,
                    ).format(widget.transaksi.totalPrice),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
