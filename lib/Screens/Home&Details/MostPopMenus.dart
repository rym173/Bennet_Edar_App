import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/commons/styles.dart';

class MostPopMenus extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String imagePath;
  final String description;
  final String price;
  final double height;
  final double width;

  MostPopMenus({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onPressed,
    required this.price,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: height * 0.23,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: width * 0.2,
                height: width * 0.2,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFonts.NameTextStyle,
                      softWrap: true,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style:  TextStyle(
                        color: Color.fromARGB(255, 62, 62, 62),
                        fontSize: width * 0.04,
                        fontFamily: 'Yaldevi',
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        price,
                        style:  TextStyle(
                          color: Color(0xFFFFB261),
                          fontSize: width * 0.05,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
