import 'dart:typed_data';

import 'package:bajukita/model/transaksi.dart';
import 'package:bajukita/repository/transaksi_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:bajukita/widget/upload_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  final Transaksi transaksi;
  const CheckoutPage({required this.transaksi, Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _txtNameController = TextEditingController();
  final _txtAlamatController = TextEditingController();
  Uint8List? _bukti;
  String? _buktiName;

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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Pengambilan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Transfer uang ke rekening berikut:',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'BRI',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '123123123123',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'BCA',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '123123123123',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Mandiri',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '123123123123',
                              style: TextStyle(
                                fontSize: 16,
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
                              'Sejumlah',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp. ',
                                decimalDigits: 0,
                              ).format(widget.transaksi.totalPrice),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            'Data Penerima',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _txtNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nama Penerima',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                            ),
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                return "Nama penerima harus diisi";
                              }
                              return null;
                            }),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _txtAlamatController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Alamat Penerima',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                            ),
                            keyboardType: TextInputType.multiline,
                            validator: ((value) {
                              if (value?.isEmpty ?? true) {
                                return "Alamat penerima harus diisi";
                              }
                              return null;
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Bukti Pembayaran',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        UploadImageWidget(
                          onImageChange: (image, name) {
                            _bukti = image;
                            _buktiName = name;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        var nama = _txtNameController.text;
                        var alamat = _txtAlamatController.text;
                        var bukti = _bukti;

                        if (nama.isEmpty ||
                            alamat.isEmpty ||
                            bukti == null ||
                            _buktiName == null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text(
                                  'Inputan bukti pembayaran tidak boleh kosong',
                                ),
                              );
                            },
                          );

                          return;
                        }
                        TransaksiRepository()
                            .checkoutDiantarkanFinal(
                          Transaksi(
                            id: widget.transaksi.id,
                            userId: widget.transaksi.userId,
                            invoiceCode: widget.transaksi.invoiceCode,
                            receipt: widget.transaksi.receipt,
                            recipient: widget.transaksi.recipient,
                            address: widget.transaksi.address,
                            totalPrice: widget.transaksi.totalPrice,
                            type: widget.transaksi.type,
                            status: widget.transaksi.status,
                          ),
                          _bukti!,
                          _buktiName!,
                        )
                            .then((value) {
                          if (value != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Berhasil simpan data pengiriman'),
                              ),
                            );
                            Navigator.of(context).pushReplacementNamed(
                              Routes.detailtransaksi,
                              arguments: value,
                            );
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
