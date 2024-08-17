import 'package:bennet_eddar_app/screens/LocationIdentification/LocationNotSupported.dart';
import 'package:bennet_eddar_app/screens/LocationIdentification/TypeLocation.dart';
import '../../widgets/top_bar_widget.dart';
import '../../widgets/title_subtitle_widget.dart';
import 'package:flutter/material.dart';

class EnterLocation extends StatelessWidget {
  const EnterLocation({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppTopBar(title: 'Trouvez des cuisiniers locaux'),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.035),
            AppSubtitle(
                text:
                    'Veuillez indiquer votre emplacement afin de trouver des cuisiniers à proximité de vous..'),
            // Adding some space between close icon and search bar

            SizedBox(
                height: screenHeight *
                    0.04), // Adding some space between text and buttons
            ElevatedButton(
              onPressed: () {
                // logic to get localisation from the phone

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationNotSupported()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFFFB261),
                backgroundColor: Color.fromARGB(255, 252, 251, 251), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      screenHeight * 0.02), // Button border radius
                  side: const BorderSide(
                    color: Color(0xFFFFB261), // Border color
                  ),
                ),
                minimumSize: Size(double.infinity,
                    screenHeight * 0.07), // Increased button height
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on), // Icon on the left
                  SizedBox(
                      width: screenWidth *
                          0.02), // Adding space between icon and text
                  const Text(
                    'Utilisez votre emplacement actuel.',
                    style: TextStyle(
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.bold // Specify your custom font family
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
                foregroundColor: const Color(0xFF6C6C6C),
                backgroundColor: const Color(0xFFFBFBFB), // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      screenHeight * 0.02), // Button border radius
                  side: const BorderSide(
                    color: Color(0xFFFBFBFB), // Border color
                  ),
                ),
                minimumSize: Size(double.infinity,
                    screenHeight * 0.07), // Increased button height
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit), // Icon on the left
                  SizedBox(
                      width: screenWidth *
                          0.02), // Adding space between icon and text
                  const Text(
                    'Entrer une nouvelle adresse.',
                    style: TextStyle(
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.bold // Specify your custom font family
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
