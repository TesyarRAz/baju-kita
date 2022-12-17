import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageWidget extends StatefulWidget {
  final Function(Uint8List?, String?)? onImageChange;
  final ImageProvider? tmpImage;

  const UploadImageWidget({Key? key, this.onImageChange, this.tmpImage})
      : super(key: key);

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  Uint8List? _image;
  String? _name;

  void openBuktiBayar(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Ambil Gambar'),
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: const Text('Galery'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: const Text('Camera'),
          )
        ],
      ),
    );

    if (result != null) {
      var imagePicker = ImagePicker();
      var image = await imagePicker.pickImage(
        source: result,
      );

      if (image != null) {
        image.readAsBytes().then((value) {
          setState(() {
            _image = value;
            _name = image.name;
          });

          if (widget.onImageChange != null) {
            widget.onImageChange!(_image, _name);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openBuktiBayar(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        height: 400,
        child: Center(
          child: _image != null
              ? Image.memory(
                  _image!,
                  height: 300,
                  width: 400,
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                )
              : (widget.tmpImage != null
                  ? Image(
                      image: widget.tmpImage!,
                      width: 400,
                      height: 300,
                    )
                  : const Text(
                      'Tap untuk memilih gambar',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Ubuntu',
                      ),
                    )),
        ),
      ),
    );
  }
}
