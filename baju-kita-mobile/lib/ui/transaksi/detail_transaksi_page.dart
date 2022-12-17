import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/transaksi.dart';
import 'package:bajukita/repository/transaksi_repository.dart';
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
  String? _status;

  @override
  void initState() {
    super.initState();

    _status = widget.transaksi.status;
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Chip(
                      label: Text(
                        StringUtils.capitalize(widget.transaksi.status),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    const Text(
                      'Kode Invoice',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    QrImage(
                      data: widget.transaksi.invoiceCode,
                      size: 200,
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.transaksi.type == 'ambil_ditempat',
                  child: const Text(
                    'Perlihatkan ke kasir untuk mengambil barang belanja anda',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
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
                                        imageUrl: data.produk!.image!,
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Penerima: ${widget.transaksi.recipient}',
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      Text(
                        'Alamat Penerima: ${widget.transaksi.address}',
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (widget.transaksi.receipt != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Bukti Pembayaran',
                              style: TextStyle(
                                fontSize: 19,
                              ),
                            ),
                            CachedNetworkImage(
                              imageUrl: widget.transaksi.receipt!,
                              height: 300,
                            ),
                          ],
                        ),
                      if (DataStatic.user?.role == 'admin')
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Update Status',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                                DropdownButton(
                                  isDense: true,
                                  items: const [
                                    DropdownMenuItem<String>(
                                      value: 'prepared',
                                      child: Text('Prepared'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'request',
                                      child: Text('Request'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'accepted',
                                      child: Text('Accepted'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'packing',
                                      child: Text('Packing'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'send',
                                      child: Text('Send'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'done',
                                      child: Text('Done'),
                                    ),
                                  ],
                                  value: _status,
                                  onChanged: (value) {
                                    setState(() {
                                      _status = value as String;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_status == null) return;

                                  TransaksiRepository()
                                      .updateStatus(
                                    _status!,
                                    widget.transaksi.id,
                                  )
                                      .then((value) {
                                    if (value != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            content: Text(
                                              'Berhasil mengupdate transaksi',
                                            ),
                                          );
                                        },
                                      ).then((value) {
                                        Navigator.of(context).pop(true);
                                      });
                                    }
                                  });
                                },
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
