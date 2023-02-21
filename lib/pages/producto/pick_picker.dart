import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget picPicker(
  bool isImageSelected,
  String fileName,
  Function onFilePicked,
) {
  Future<XFile?> imageFile;
  ImagePicker picker = ImagePicker();

  return Column(
    children: [
      fileName.isNotEmpty
          ? isImageSelected
              ? Image.file(
                  File(fileName),
                  width: 300,
                  height: 300,
                )
              : SizedBox(
                  child: Image.network(
                    fileName,
                    width: 200,
                    height: 200,
                    fit: BoxFit.scaleDown,
                  ),
                )
          : SizedBox(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                width: 200,
                height: 200,
                fit: BoxFit.scaleDown,
              ),
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 35.0,
            width: 35.0,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.image, size: 35.0),
              onPressed: () {
                imageFile = picker.pickImage(source: ImageSource.gallery);
                imageFile.then((file) async {
                  onFilePicked(file);
                });
              },
            ),
          ),
          SizedBox(
            height: 35.0,
            width: 35.0,
            child: IconButton(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              icon: const Icon(Icons.camera, size: 35.0),
              onPressed: () {
                imageFile = picker.pickImage(source: ImageSource.camera);
                imageFile.then((file) async {
                  onFilePicked(file);
                });
              },
            ),
          ),
        ],
      ),
    ],
  );
}
