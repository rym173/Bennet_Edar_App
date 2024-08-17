import 'package:bennet_eddar_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/screens/IntroductoryPages/WalkThrough.dart';
import 'package:flutter/services.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: screenWidth * 0.000004),
              child: Text(
                'Bienvenue sur',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: screenHeight * 0.05,
                  fontFamily: 'Yaldevi',
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Image.asset(
              'assets/image/Logo.png',
              width: screenWidth * 0.9,
              height: screenHeight * 0.6,
              fit: BoxFit.cover,
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Nous vous offrons l'expérience de déguster des plats faits\n maison où que vous soyez, quand vous le souhaitez !",
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color:Color(0xFF6C6C6C),
                fontWeight: FontWeight.bold,
                fontFamily: 'Yaldevi'
                
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.04),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: screenWidth * 0.9,
                child: AppElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WalkThrough()),
                    );
                  },
                  label: "COMMENCER",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
