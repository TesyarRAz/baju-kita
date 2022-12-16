import 'package:bajukita/model/transaksi.dart';
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
                            Text(
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
                              style: TextStyle(
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
                          Text(
                            'Data Penerima',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _txtNameController,
                            decoration: InputDecoration(
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
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _txtAlamatController,
                            decoration: InputDecoration(
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
                        Text(
                          'Bukti Pembayaran',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        UploadImageWidget(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
