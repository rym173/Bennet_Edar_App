import 'package:bennet_eddar_cook/screens/LocationIdentification/LocationNotSupported.dart';
import 'package:bennet_eddar_cook/screens/LocationIdentification/TypeLocation.dart';
import 'package:flutter/material.dart';

class EnterLocation extends StatelessWidget {
  const EnterLocation({super.key});

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
                  icon: const Icon(Icons.arrow_back_ios),
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
                color: const Color.fromRGBO(1, 15, 7, 1),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height:
                    screenHeight * 0.04), // Adding some space between close icon and search bar
            Text(
              'Veuillez indiquer votre emplacement afin de trouver des utilisateurs à proximité de vous.',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
                fontFamily: 'Yaldevi',
                color: const Color(0xFF6C6C6C),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.04), // Adding some space between text and buttons
            ElevatedButton(
              onPressed: () {
                // logic to get localisation from the phone
                              
                               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LocationNotSupported()),
                );
              },
            
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFFFB261), backgroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.02), // Button border radius
                  side: const BorderSide(
                    color: Color(0xFFFFB261), // Border color
                  ),
                ),
                minimumSize: Size(double.infinity, screenHeight * 0.07), // Increased button height
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on), // Icon on the left
                  SizedBox(width: screenWidth * 0.02), // Adding space between icon and text
                  const Text(
                    'Utilisez votre emplacement actuel.',
                    style: TextStyle(
                      fontFamily: 'Yaldevi', // Specify your custom font family
                    ),
                  ), // Button text
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.035),
            ElevatedButton(
              onPressed: () {
                               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TypeLocation()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF6C6C6C), backgroundColor: const Color(0xFFFBFBFB), // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.02), // Button border radius
                  side: const BorderSide(
                    color: Color(0xFFFBFBFB), // Border color
                  ),
                ),
                minimumSize: Size(double.infinity, screenHeight * 0.07), // Increased button height
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit), // Icon on the left
                  SizedBox(width: screenWidth * 0.02), // Adding space between icon and text
                  const Text(
                    'Entrer une nouvelle adresse.',
                    style: TextStyle(
                      fontFamily: 'Yaldevi', // Specify your custom font family
                    ),
                  ), // Button text
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



