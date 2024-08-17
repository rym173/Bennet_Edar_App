import 'package:flutter/material.dart';


class CookGalleryRow extends StatelessWidget {
  final List<String> images;

  const CookGalleryRow({super.key, required this.images});

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

  const CookGallerySquare({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Image.asset(
        imagePath,
        width: 120.0,
        height: 120.0,
        fit: BoxFit.cover,
      ),
    );
  }
}





