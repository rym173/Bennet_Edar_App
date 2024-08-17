import '../../main.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import '../database/db_picture_paths.dart';
import 'package:connectivity/connectivity.dart';
import '../database/db_pictures.dart';

class GalleryPictures{
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
  static Future<void> insertPictureFromFirebaseStorage(int cookID) async {
    String folderPath = 'CooksGallery/$cookID';
    bool allDeleted =await PicturesDB.deleteAllPictures();
    
    if(allDeleted){
      ListResult result = await FirebaseStorage.instance.ref(folderPath).list();
      for (var item in result.items) {
        final Uint8List? imageBytes = await item.getData();

        if (imageBytes != null) {
          final Map<String, dynamic> pictureData = {
            'name': item.name,
            'cookID': cookID,
            'image': imageBytes,
          };

          await PicturesDB.insertPicture(pictureData);
          print("added to local db");
        }
      }
    }
  }
  static Future<bool> gallery_Images(int cookID , String localPath) async {
    try {
      String filename = '$cookID${DateTime.now().millisecondsSinceEpoch}.jpg';
      final spaceRef = storageRef.child("CooksGallery/$cookID/$filename");
      await spaceRef.putFile(File(localPath));
      print('inserted');
      return true;
    } catch (e) {
      print("Exception $e");
      return false;
    }
  }
  static Future<void> uploadImagesToFirebaseStorageIfConnected (bool isConnected) async {
    List<Map<String, dynamic>> picturePaths = await PicturesPathDB.getAllPicturesPaths();
    if (isConnected && picturePaths.isNotEmpty){
      for (Map<String, dynamic> picturePath in picturePaths) {
        int cookID = picturePath['cookID'];
        String image = picturePath['image'];
        gallery_Images(cookID, image);
      }
      print("inserted after connection");
      await PicturesPathDB.deleteAllpicturePaths();
    }
  }
  static Future<bool> deleteImageFromStorage(int cookID , String imageName) async {
    try {
      Reference imageRef = storage.ref().child('CooksGallery/$cookID/$imageName');

      await imageRef.delete();
      await PicturesDB.deletePicture(imageName);

      print('Image $imageName deleted successfully from Firebase Storage');
      return true;
    } catch (e) {
      print('Error deleting image: $imageName');
      print("cookID : $cookID");
      print('CooksGallery/$cookID/$imageName');
      return false;
    }
  }
  
}