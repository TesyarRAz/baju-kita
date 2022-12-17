import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Wrap(
              children: [
                Text(
                  'Toko BAJUKITA merupakan salah satu contoh usaha bisnis yang berjalan dibagian pemesanan dan penjualan baju yang berlokasi di sukabumi.Dalam mengembangkan bisnisnya, toko BAJUKITA berupaya untuk memuaskan konsumen dan membuat konsumen percaya, dengan menggunakan bahan-bahan yang berkualitas baik.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              "assets/images/about.jpg",
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
