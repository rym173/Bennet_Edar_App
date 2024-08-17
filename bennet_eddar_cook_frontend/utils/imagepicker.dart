import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
Future<String?> AploadImage(
    ImageSource source, BuildContext context) async {
  if (context.mounted) {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 70,
      );
      return pickedFile!.path;
    } catch (e) {}
    return null;
  }
  return null;
}

Future<List<String>?> AploadImages(
    ImageSource source, BuildContext context) async {
  if (context.mounted) {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 70,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        List<String> paths = pickedFiles.map((file) => file.path).toList();
        return paths;
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  return null;
}