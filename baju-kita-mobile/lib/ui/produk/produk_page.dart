import 'package:bajukita/data/static.dart';
import 'package:bajukita/model/kategori.dart';
import 'package:bajukita/model/produk.dart';
import 'package:bajukita/repository/kategori_repository.dart';
import 'package:bajukita/repository/produk_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:bajukita/widget/produk_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final _kategoriController = TextEditingController();

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
        actions: [
          if (DataStatic.user?.role == 'admin')
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'tambah_kategori') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Tambah Kategori'),
                        content: TextField(
                          controller: _kategoriController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Simpan'),
                            onPressed: () {
                              var kategori = _kategoriController.text;
                              if (kategori.isEmpty) {
                                return;
                              }
                              KategoriRepository()
                                  .store(kategori)
                                  .then((value) {
                                if (value) {
                                  Navigator.of(context).pop();
                                  if (value) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content:
                                              Text('Berhasil Tambah kategori'),
                                        );
                                      },
                                    );
                                    _kategoriController.clear();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content:
                                              Text('Gagal tambah kategori'),
                                        );
                                      },
                                    );
                                  }

                                  setState(() {});
                                }
                              });
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Tidak'),
                          )
                        ],
                      );
                    },
                  );
                } else if (value == 'hapus_kategori') {
                  KategoriRepository().list().then((value) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text('Kategori yang ingin dihapus'),
                          children: value
                              ?.map((e) => TextButton(
                                    onPressed: () {
                                      KategoriRepository()
                                          .delete(e.id)
                                          .then((value) {
                                        Navigator.of(context).pop();
                                        if (value) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    'Berhasil hapus kategori'),
                                              );
                                            },
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    'Gagal hapus kategori'),
                                              );
                                            },
                                          );
                                        }
                                        setState(() {});
                                      });
                                    },
                                    child: Text(e.name),
                                  ))
                              .toList(),
                        );
                      },
                    );
                  });
                } else if (value == 'tambah_produk') {
                  Navigator.of(context)
                      .pushNamed(
                    Routes.adminprodukmodify,
                  )
                      .then((value) {
                    setState(() {});
                  });
                }
              },
              itemBuilder: ((context) {
                return [
                  const PopupMenuItem<String>(
                    value: "tambah_produk",
                    child: Text('Tambah Produk'),
                  ),
                  const PopupMenuItem<String>(
                    value: "tambah_kategori",
                    child: Text('Tambah Kategori'),
                  ),
                  const PopupMenuItem<String>(
                    value: "hapus_kategori",
                    child: Text('Hapus Kategori'),
                  ),
                ];
              }),
            ),
        ],
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
                      key: ValueKey(e.id),
                      produk: e,
                      onPoppedDetail: (value) {
                        if (value == true) {
                          setState(() {});
                        }
                      },
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
