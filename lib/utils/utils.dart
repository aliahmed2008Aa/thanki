import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

picImage(ImageSource source) async {
  final ImagePicker _imagePicker = new ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("no image selected");
}

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(text)),);
}
