import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/kategori.dart';
import 'package:bajukita/model/produk.dart';
import 'package:bajukita/repository/kategori_repository.dart';
import 'package:bajukita/repository/produk_repository.dart';
import 'package:bajukita/widget/produk_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProdukPage extends StatefulWidget {
  final int? initialKategoriId;

  const ProdukPage({this.initialKategoriId, Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  int? _filterKategori;
  String? _search;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _filterKategori = widget.initialKategoriId;
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gapPadding: 0,
                    ),
                    hintText: 'Pencarian',
                    suffix: Icon(Icons.search),
                  ),
                  onEditingComplete: () => setState(() {
                    _search = _searchController.text;
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Filter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                FutureBuilder<List<Kategori>?>(
                  future: KategoriRepository().list(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Wrap(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<int?>(
                                value: null,
                                groupValue: _filterKategori,
                                onChanged: (value) {
                                  setState(() {
                                    _filterKategori = value;
                                  });
                                },
                              ),
                              GestureDetector(
                                child: const Text("Semua"),
                                onTap: () => setState(() {
                                  _filterKategori = null;
                                }),
                              ),
                            ],
                          ),
                          ...snapshot.data!.map((e) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<int?>(
                                  value: e.id,
                                  groupValue: _filterKategori,
                                  onChanged: (value) {
                                    setState(() {
                                      _filterKategori = value;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Text(e.name),
                                  onTap: () => setState(() {
                                    _filterKategori = e.id;
                                  }),
                                ),
                              ],
                            );
                          }).toList(),
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
          ),
          FutureBuilder<List<Produk>?>(
            future: ProdukRepository().list(
              kategoriId: _filterKategori,
              search: _search,
            ),
            builder: ((context, snapshot) {
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
                return const Center(
                  child: Text('Data tidak terload'),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          )
        ],
      ),
    );
  }
}
