import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_complete/service/authRepositry.dart';

Future<List<File>> pickImages({required BuildContext context}) async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    showSnackBar(e.toString(), context);
  }
  return images;
}

String ip = "http://localhost:3001";
