import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/commons/styles.dart';

class MostPopMenus extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String imagePath;
  final String description;
  final String price;

  MostPopMenus({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onPressed,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 120.0, 
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 80.0, 
                height: 80.0, 
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
                      style: const TextStyle(
                        color: Color.fromARGB(255, 62, 62, 62),
                        fontSize: 15,
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
                        style: const TextStyle(
                          color: Color(0xFFFFB261),
                          fontSize: 18,
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
