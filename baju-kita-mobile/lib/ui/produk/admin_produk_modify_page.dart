import 'dart:typed_data';

import 'package:bajukita/model/kategori.dart';
import 'package:bajukita/model/produk.dart';
import 'package:bajukita/repository/kategori_repository.dart';
import 'package:bajukita/repository/produk_repository.dart';
import 'package:bajukita/widget/upload_image_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminProdukModifyPage extends StatefulWidget {
  final Produk? produk;

  const AdminProdukModifyPage({Key? key, this.produk}) : super(key: key);

  @override
  State<AdminProdukModifyPage> createState() => _AdminProdukModifyPageState();
}

class _AdminProdukModifyPageState extends State<AdminProdukModifyPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _namaProdukTextboxController = TextEditingController();
  final _bahanProdukTextboxController = TextEditingController();
  final _stokProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();
  int? _kategori = null;
  Uint8List? _image;
  String? _imageName;

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _namaProdukTextboxController.text = widget.produk?.name ?? '';
        _bahanProdukTextboxController.text = widget.produk?.bahan ?? '';
        _stokProdukTextboxController.text =
            widget.produk?.stok.toString() ?? '';
        _hargaProdukTextboxController.text =
            widget.produk?.price.toString() ?? '';
        _kategori = widget.produk?.kategoriId;
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaProdukTextField(),
                const SizedBox(
                  height: 20,
                ),
                _bahanProdukTextField(),
                const SizedBox(
                  height: 20,
                ),
                _stokProdukTextField(),
                const SizedBox(
                  height: 20,
                ),
                _hargaProdukTextField(),
                const SizedBox(
                  height: 20,
                ),
                _kategoriProdukField(),
                const SizedBox(
                  height: 20,
                ),
                _imageProdukField(),
                const SizedBox(
                  height: 20,
                ),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama Produk",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Nama Produk Harus Diisi";
        }
        return null;
      },
    );
  }

  // Textbox Bahan Produk
  Widget _bahanProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Bahan',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      keyboardType: TextInputType.text,
      controller: _bahanProdukTextboxController,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Bahan Harus Diisi";
        }
        return null;
      },
    );
  }

  // Textbox Stok Produk
  Widget _stokProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Stok',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      keyboardType: TextInputType.number,
      controller: _stokProdukTextboxController,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Stok Harus Diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harga",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _kategoriProdukField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Kategori',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          width: 50,
        ),
        FutureBuilder<List<Kategori>?>(
          future: KategoriRepository().list(),
          builder: (context, snapshot) {
            return Expanded(
              child: DropdownButton<int>(
                isExpanded: true,
                items: (snapshot.data ?? [])
                    .map((e) => DropdownMenuItem<int>(
                          value: e.id,
                          child: Text(e.name),
                        ))
                    .toList(),
                value: _kategori,
                onChanged: (value) {
                  setState(() {
                    _kategori = value;
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _imageProdukField() {
    return UploadImageWidget(
      onImageChange: (image, name) {
        _image = image;
        _imageName = name;
      },
      tmpImage: widget.produk?.image != null
          ? NetworkImage(widget.produk?.image ?? '')
          : null,
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text(
          tombolSubmit,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          var validate = _formKey.currentState?.validate() ?? false;
          if (validate) {
            if (!_isLoading) {
              if (widget.produk != null) {
                // Kondisi Update Produk
                ubah();
              } else {
                // kondisi tambah produk
                simpan();
              }
            }
          }
        },
      ),
    );
  }

  simpan() {
    if (_kategori == null || _image == null || _imageName == null) return;
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(
      id: 0,
      name: _namaProdukTextboxController.text,
      price: int.parse(_hargaProdukTextboxController.text),
      bahan: _bahanProdukTextboxController.text,
      stok: int.parse(_stokProdukTextboxController.text),
      kategoriId: _kategori!,
      image: null,
    );
    ProdukRepository().store(createProduk, _image!, _imageName!).then((value) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Berhasil tambah produk'),
          );
        },
      ).then((value) {
        Navigator.of(context).pop(true);
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Gagal tambah produk'),
          );
        },
      ).then((value) {
        Navigator.of(context).pop(true);
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  ubah() {
    if (_kategori == null) return;
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(
      id: widget.produk?.id ?? 0,
      name: _namaProdukTextboxController.text,
      price: int.parse(_hargaProdukTextboxController.text),
      bahan: _bahanProdukTextboxController.text,
      stok: int.parse(_stokProdukTextboxController.text),
      kategoriId: _kategori!,
      image: null,
    );
    ProdukRepository().update(updateProduk, _image, _imageName).then((value) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Berhasil edit produk'),
          );
        },
      ).then((value) {
        Navigator.of(context).pop(true);
      });
    }).catchError((error) {
      if (kDebugMode) {
        print((error as DioError).response?.data);
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Gagal edit produk'),
          );
        },
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
