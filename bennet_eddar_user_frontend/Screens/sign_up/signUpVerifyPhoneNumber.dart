import 'package:flutter/material.dart';
import 'centered_text_widget.dart';
import '../../widgets/top_bar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/title_subtitle_widget.dart';
import '../../widgets/input_square_widget.dart';
import 'SignUp.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  @override
  _VerifyPhoneNumberScreenState createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: 'Inscription'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTitle(text: 'Vérifiez votre numéro de téléphone'),
                  SizedBox(height: 30),
                  AppSubtitle(
                      text: 'Entrez le code à 4 chiffres envoyé à votre numéro de téléphone'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 4; i++)
                        InputSquare(
                            controller: controllers[i],
                            focusNode: focusNodes[i]),
                    ],
                  ),
                 const SizedBox(height: 50),
// Inside the _ResetCodeSentScreenState class
                  AppElevatedButton(
                    onPressed: () {

                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SignUp(),
                          ),
                        );
                      // Add logic to verify the entered code
                      
                      String verificationCode = controllers
                          .map((controller) => controller.text)
                          .join();
                      print('Code saisi: $verificationCode');

                      // Navigate to the form page
                         
                    },
                    label: 'VÉRIFIER LE CODE',
                  ),

                  SizedBox(height: 20),
                  AppElevatedButton(
                    onPressed: () {},
                    label: 'RENVOYER',
                  ),
                  SizedBox(height: 40),

  // Inside your screen or another widget
          const AppCenteredText(text: 'En vous inscrivant, vous acceptez nos conditions d\'utilisation et notre politique de confidentialité.'),

                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
