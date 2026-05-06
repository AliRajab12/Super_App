import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploader {
  static Future<File?> pickAndUploadFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      // Check if file size is less than 4MB
      if (await file.length() <= 4 * 1024 * 1024) {
        return file;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("File size exceeds 4MB"),
        ));
        return null;
      }
    } else {
      // User canceled the file picker
      return null;
    }
  }
}
