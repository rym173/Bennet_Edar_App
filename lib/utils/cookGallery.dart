import '../../main.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:connectivity/connectivity.dart';

class GalleryPictures{
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
  static Future<List<Uint8List>> insertPictureFromFirebaseStorage(int cookID) async {
    String folderPath = 'CooksGallery/$cookID';
    List <Uint8List> cookPictures=[];
    ListResult result = await FirebaseStorage.instance.ref(folderPath).list();
    for (var item in result.items) {
      final Uint8List? imageBytes = await item.getData();

      if (imageBytes != null) {
        cookPictures.add(imageBytes);
      }
    }
    print("added to the list ");
    return cookPictures;
  }
}