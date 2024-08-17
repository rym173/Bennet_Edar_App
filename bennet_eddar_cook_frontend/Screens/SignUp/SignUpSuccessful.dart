import 'package:bennet_eddar_cook/screens/cook_profile/registerCook.dart';
import 'package:bennet_eddar_cook/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class SignUpSuccessful extends StatelessWidget {
  const SignUpSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
                            padding: EdgeInsets.fromLTRB(
          screenWidth * 0.05,
          screenHeight * 0.09,
          screenWidth * 0.05,
          0.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Image.asset(
                'assets/image/SignUpSuccess.png', // Replace with the actual path to your image
                height: screenHeight * 0.4, // Adjust the height as needed
                width: screenWidth * 0.4, // Adjust the width as needed
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Yeay! C'est terminé.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Yaldevi',
                  color: Color(0xFF020202),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                "Désormais, vous pouvez partager votre passion pour la cuisine avec le monde, un plat délicieux à la fois. Bonne cuisine !",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Yaldevi',
                  color: Color(0xFF8D92A3),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.08),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: AppElevatedButton(
                    onPressed: () {

                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  RegisterCookScreen()),
                        );
                          // menu page 
              },
              
                    label: "C'EST PARTI",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
