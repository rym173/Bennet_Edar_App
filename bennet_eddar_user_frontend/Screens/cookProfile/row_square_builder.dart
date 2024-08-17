import 'package:flutter/material.dart';


class CookGalleryRow extends StatelessWidget {
  final List<String> images;

  CookGalleryRow({required this.images});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var imagePath in images)
          CookGallerySquare(imagePath: imagePath),
        
      ],
    );
  }
}


class CookGallerySquare extends StatelessWidget {
  final String imagePath;

  CookGallerySquare({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Image.asset(
        imagePath,
        width: 120.0,
        height: 120.0,
        fit: BoxFit.cover,
      ),
    );
  }
}





