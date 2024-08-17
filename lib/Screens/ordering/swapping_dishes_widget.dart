import 'package:flutter/material.dart';
import '../../commons/styles.dart';


class SwappingImageWithText extends StatefulWidget {
  final List<ImageTextModel> data;

  SwappingImageWithText({required this.data});

  @override
  _SwappingImageWithTextState createState() => _SwappingImageWithTextState();
}

class _SwappingImageWithTextState extends State<SwappingImageWithText> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            child: PageView.builder(
              itemCount: widget.data.length,
              controller: PageController(viewportFraction: 0.9), // Adjust the viewportFraction
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return ImageWithText(
                  imagePath: widget.data[index].imagePath,
                  title: widget.data[index].title,
                  description: widget.data[index].description,
                );
              },
            ),
          ),
          const SizedBox(height: 26),
          Text(
            widget.data[currentIndex].title,
            style: AppFonts.dishNameTextstyle,
            softWrap: true,
          ),
          const SizedBox(height: 30),
          Container(
            child: Opacity(
              opacity: 0.7,
              child: FittedBox(
                fit: BoxFit.scaleDown, 
                child: Text(
                  widget.data[currentIndex].description,
                  style: AppFonts.dishDescTextstyle,
                  softWrap: true,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}


class ImageWithText extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  ImageWithText({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: screenWidth, 
          height: 180, 
        ),
      ),
    );
  }
}


class ImageTextModel {
  final String imagePath;
  final String title;
  final String description;

  ImageTextModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}




