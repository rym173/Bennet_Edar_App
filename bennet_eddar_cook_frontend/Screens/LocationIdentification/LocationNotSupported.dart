import 'package:flutter/material.dart';

class LocationNotSupported extends StatelessWidget {
  const LocationNotSupported({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
                padding: EdgeInsets.fromLTRB(
          screenWidth * 0.04,
          screenHeight * 0.04,
          screenWidth * 0.04,
          0.0, // Add some padding at the top
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                // Close icon at the top left
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    // Handle close button tap
                    Navigator.of(context).pop(); // For example, pop the current screen
                  },
                ),
              ],
            ),
            SizedBox(
                height:
                    screenHeight * 0.016), // Adding some space between close icon and search bar
            // Text at the top center of the page
            Text(
              'Recherchez des utilisateurs à proximité',
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w200,
                fontFamily: 'Yaldevi',
                color: const Color(0xFF010F07),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height:
                    screenHeight * 0.035), 
            Image.asset(
              'assets/image/LocationNotSupported.png',
              height: screenHeight * 0.3,
              width: screenWidth * 0.3,
            ),
            SizedBox(
                height:
                    screenHeight * 0.035), // Adding some space between image and other elements
            Text(
              "Cette région n'est actuellement pas prise en charge par notre application. On sera bientôt disponible.",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
                fontFamily: 'Yaldevi',
                color: const Color(0xFF6C6C6C),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
