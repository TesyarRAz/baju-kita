import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/kategori.dart';
import 'package:bajukita/model/produk.dart';
import 'package:bajukita/repository/kategori_repository.dart';
import 'package:bajukita/repository/produk_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:bajukita/widget/conditional_widget.dart';
import 'package:bajukita/widget/produk_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
        actions: [
          if (DataStatic.user != null && DataStatic.user?.role != 'admin')
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.keranjang);
              },
            ),
        ],
      ),
      body: ListView(
        primary: true,
        children: [
          const SizedBox(
            height: 1,
          ),
          CarouselSlider(
            items: [
              _buildCarousel('assets/images/banner1.jpg'),
              _buildCarousel('assets/images/banner2.jpg'),
              _buildCarousel('assets/images/banner3.jpg'),
            ],
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              pageSnapping: true,
              viewportFraction: 1,
              initialPage: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rekomendasi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<Produk>?>(
                  future: ProdukRepository().recommended(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return StaggeredGrid.count(
                        crossAxisCount: 2,
                        children: snapshot.data!.map((e) {
                          return ProdukItemWidget(
                            produk: e,
                          );
                        }).toList(),
                      );
                    }
                    if (snapshot.hasError) {
                      if (kDebugMode) {
                        print(snapshot.error);
                      }
                      return const Text(
                        'Terjadi Kesalahan',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          FutureBuilder<List<Kategori>?>(
            future: KategoriRepository().list(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Daftar Kategori',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ),
                    Card(
                      child: ListView(
                        shrinkWrap: true,
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: snapshot.data!.map((e) {
                            return ListTile(
                              title: Text(e.name),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  Routes.produk,
                                  arguments: <String, dynamic>{
                                    'kategori_id': e.id,
                                  },
                                );
                              },
                            );
                          }).toList(),
                        ).toList(),
                      ),
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                if (kDebugMode) {
                  print(snapshot.error);
                }
                return const Text('Terjadi kesalahan');
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(String assetName) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(assetName),
        ),
      ),
    );
  }
}
