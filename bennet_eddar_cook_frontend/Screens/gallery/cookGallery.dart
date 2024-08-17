import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../widgets/top_bar_widget.dart';
import '../../utils/imagepicker.dart';
import '../../database/db_pictures.dart';
import '../../database/db_picture_paths.dart';
import '../../utils/galleryPictures.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import '../../models/Picture.dart';

late int cookID;
Future<void> CookID() async {
    String? userID = await getUserId();
    if (userID != null) {
      cookID = int.parse(userID);
    } else {
      print('error getting user id');
    }
  }

bool isLoading = true;

class CookGalleryScreen extends StatefulWidget {
  @override
  _CookGalleryScreenState createState() => _CookGalleryScreenState();
}

class _CookGalleryScreenState extends State<CookGalleryScreen> {
  List<Picture> images = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    CookID();
    loadImagesFromDatabase();
  }

  Future<void> processImages() async {
    List<String>? selectedImages = await AploadImages(ImageSource.gallery, context);
    bool connected = await GalleryPictures.checkInternetConnection();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      if (connected) {
        for (String image in selectedImages) {
          GalleryPictures.gallery_Images(cookID, image);
          await GalleryPictures.insertPictureFromFirebaseStorage(cookID);
        }
        await loadImagesFromDatabase();
      } else {
        for (String image in selectedImages) {
          final Map<String, dynamic> pictureData = {
            'cookID': cookID,
            'image': image,
          };
          await PicturesPathDB.insertPicturePath(pictureData);
        }
      }
    }
  }

  Future<List<Picture>> loadImagesFromDatabase() async {
    List<Map<String, dynamic>> dbImages = await PicturesDB.getAllPictures();
    List<Picture> pictureList = dbImages.map((image) {
      return Picture(
        name: image['name'],
        cookID: image['cookID'],
        picture: image['image'] as Uint8List,
      );
    }).toList();

    setState(() {
      images = pictureList;
      isLoading = false;
    });

    return pictureList;
  }

  Future<void> refreshData() async {
    bool connected = await GalleryPictures.checkInternetConnection();
    if (connected) {
      await GalleryPictures.insertPictureFromFirebaseStorage(cookID);
      await loadImagesFromDatabase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: 'Gallerie',
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: Color(0xFFFFB261),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : images.isEmpty
                  ? ListView(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                        Center(
                          child: Text(
                            'Aucune image disponible',
                            style: TextStyle(fontSize: 20.0, fontFamily: 'Yaldevi'),
                          ),
                        )
                      ],
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CookGalleryDetailScreen(
                                    images: images,
                                    initialIndex: index,
                                  ),
                                ),
                              ).then((value) {
                                setState(() async {
                                  isLoading = true;
                                  await loadImagesFromDatabase();
                                  isLoading = false;
                                });
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: MemoryImage(images[index].picture),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          setState(() async{
          isLoading = true;
          await processImages();
          isLoading = false;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFFFB261),
      ),
    );
  }
}


class CookGalleryDetailScreen extends StatelessWidget {
  final List<Picture> images;
  final int initialIndex;

  CookGalleryDetailScreen({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    Picture currentPicture = images[initialIndex];


    Future<bool> deletePicture () async{
      
      // ignore: unused_local_variable
      bool isDeleted = await GalleryPictures.deleteImageFromStorage(cookID , currentPicture.name);
      return true;
    }
    
    Future<void> _showDeleteConfirmationDialog() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Suppression'),
            content: Text('Êtes-vous sûr de vouloir supprimer cette photo ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Annuler'),
              ),
              TextButton(
                onPressed: () async {
                 bool isDeleted = await deletePicture(); 
                  if (isDeleted){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                 
                },
                child: Text('Valider'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          currentPicture = images[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: MemoryImage(images[index].picture),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        itemCount: images.length,
        backgroundDecoration: BoxDecoration(
          color: Colors.white,
        ),
        pageController: PageController(initialPage: initialIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDeleteConfirmationDialog();
          print(cookID);
        },
        child: Icon(
          Icons.delete,
          color: Colors.white,),
        backgroundColor: Colors.black, 
      ),
    );
  }

}