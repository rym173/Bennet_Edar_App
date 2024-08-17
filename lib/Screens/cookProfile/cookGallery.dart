import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../widgets/top_bar_widget.dart';
import '../../utils/cookGallery.dart';

class CookGalleryScreen extends StatefulWidget {
  @override
  _CookGalleryScreenState createState() => _CookGalleryScreenState();
}

class _CookGalleryScreenState extends State<CookGalleryScreen> {
  List<Uint8List> images = [];
  int cookID = 30;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadImagesFromDatabase();
  }

  Future<void> loadImagesFromDatabase() async {
    setState(() {
      isLoading = true;
    });

    List<Uint8List> imageBytes = await GalleryPictures.insertPictureFromFirebaseStorage(cookID);

    setState(() {
      images = imageBytes;
      isLoading = false;
    });
  }

  Future<void> refreshData() async {
    bool connected = await GalleryPictures.checkInternetConnection();
    if (connected) {
      await GalleryPictures.insertPictureFromFirebaseStorage(cookID);
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
              ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFB261))))
              : CookGalleryThumbnails(images: images),
        ),
      ),
    );
  }
}

class CookGalleryThumbnails extends StatelessWidget {
  final List<Uint8List> images;

  CookGalleryThumbnails({required this.images});

  @override
  Widget build(BuildContext context) {
    return images.isEmpty
        ? Center(
            child: Text(
              'Aucune image disponible',
              style: TextStyle(fontSize: 20.0, fontFamily: 'Yaldevi'),
            ),
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
                        builder: (context) => CookGalleryDetailScreen(images: images, initialIndex: index),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: MemoryImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}

class CookGalleryDetailScreen extends StatelessWidget {
  final List<Uint8List> images;
  final int initialIndex;

  CookGalleryDetailScreen({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
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
          return PhotoViewGalleryPageOptions(
            imageProvider: MemoryImage(images[index]),
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
    );
  }
}
