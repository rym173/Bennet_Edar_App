import 'package:bennet_eddar_app/commons/images.dart';
import 'package:flutter/material.dart';
import '../../widgets/title_subtitle_widget.dart';


class LocationNotSupported extends StatelessWidget {
  const LocationNotSupported({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical:screenWidth * 0.09),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        
          children: [
            Row(
              
              children: [
                SizedBox(
                height:
                    screenHeight * 0.05), 
                // Close icon at the top left
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    // Handle close button tap
                    Navigator.of(context).pop(); 
                    Navigator.of(context).pop(); // For example, pop the current screen
                    // For example, pop the current screen
                  },
                ),
              ],
            ),
          
            Text(
              'Trouvez des cuisiniers locaux',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                fontFamily: 'Yaldevi',
                color: const Color(0xFF010F07),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height:
                    screenHeight * 0.1), 
            Image.asset(
              LocNotSupp_image,
              height: screenHeight * 0.38,
              width: screenWidth * 0.38,
            ),
            SizedBox(
                height:
                    screenHeight * 0.035),
                    Container(
                      padding: EdgeInsets.all(14),
                      child:AppSubtitle(
                        text: "Cette région n'est actuellement pas prise en charge par notre application. On sera bientôt disponible.",
                        ) ,
                      ) // Adding some space between image and other elements
            
          ],
        ),
      ),
    );
  }
}
