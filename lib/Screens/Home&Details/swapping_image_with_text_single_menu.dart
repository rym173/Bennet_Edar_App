import 'package:bennet_eddar_app/commons/colors.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            child: PageView.builder(
              itemCount: widget.data.length,
              controller: PageController(viewportFraction: 0.9),
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
                  price: widget.data[index].price, // Add this line
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ Text(
            '${widget.data[currentIndex].title}', // Modify this line
            style: AppFonts.dishNameTextstyle,
            softWrap: true,
          ), Text(
            '${widget.data[currentIndex].price} DA', // Modify this line
            style: const TextStyle(
              color: AppColors.accentColor,
              fontSize: 25,
              fontFamily: 'Yaldevi',
              fontWeight: FontWeight.bold,
           
            )
            
          ),],),
          
          const SizedBox(height: 15),
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
  final int price; 

  ImageWithText({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price, 
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: screenWidth,
              height: 172,
            ),
          ),

        ],
      ),
    );
  }
}

class ImageTextModel {
  final String imagePath;
  final String title;
  final String description;
  final int price; 

  ImageTextModel({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price, 
  });
}
