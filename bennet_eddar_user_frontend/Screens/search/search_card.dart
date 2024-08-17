import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/screens/Home&Details/singleMenu.dart'; // Import the SingleMenu page

class SearchCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String cookName;
  final String cookProfileImage;
  final String postTime;

  SearchCard({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.cookName,
    required this.cookProfileImage,
    required this.postTime,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.8; // Adjust the factor as needed

    return InkWell(
      onTap: () {
        // Navigate to the SingleMenu page when the card is pressed
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleMenu( id: '1',), // Add the appropriate parameters if needed
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: cardWidth * 1.392, // Maintain the aspect ratio
        child: Stack(
          children: [
            Container(
              width: cardWidth,
              height: cardWidth * 1.392,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              left: 0,
              top: cardWidth * 1, // Adjust the position based on the aspect ratio
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF010F07),
                      fontSize: 20,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.44,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF868686),
                      fontSize: 16,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: -0.40,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 0,
              child: Container(
                width: cardWidth * 0.55,
                height: cardWidth * 0.97,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 9,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 11,
                    backgroundImage: AssetImage(cookProfileImage),
                  ),
                  SizedBox(height: 4, width: 4),
                  Text(
                    cookName,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 249, 249, 249),
                      fontSize: 12,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    postTime,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 250, 249, 249),
                      fontSize: 12,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
