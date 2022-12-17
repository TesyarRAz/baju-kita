import 'dart:async';

import 'package:bajukita/model/produk.dart';
import 'package:bajukita/repository/api.dart';
import 'package:bajukita/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ProdukItemWidget extends StatelessWidget {
  final Produk produk;
  final Function(Object?)? onPoppedDetail;

  const ProdukItemWidget({required this.produk, this.onPoppedDetail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => {
          Navigator.of(context)
              .pushNamed(Routes.detailproduk, arguments: produk)
              .then((value) {
            if (onPoppedDetail != null) onPoppedDetail!(value);
          })
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: produk.image,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) => Container(
                  height: 200,
                ),
                errorWidget: ((context, url, error) {
                  return const Center(
                    child: Text('Tidak terload'),
                  );
                }),
              ),
              Text(produk.name),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp. ',
                  decimalDigits: 0,
                ).format(produk.price),
                style: const TextStyle(
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
