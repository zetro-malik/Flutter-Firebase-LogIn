import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


  void customSnackBar(String head, String body) {
    Get.snackbar(head, body,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        backgroundColor: Colors.deepPurpleAccent,
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return  _file;
  }
  print('no Image selected');
}



Uint8List fileToUint8List(String filePath) {
  File file = File(filePath);
  Uint8List uint8list = file.readAsBytesSync();
  return uint8list;
}


