import 'package:flutter/material.dart';
import '../../../widgets/top_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/title_subtitle_widget.dart';
import '../../../widgets/input_square_widget.dart';
import 'resetPage.dart';

class ResetCodeSentScreen extends StatefulWidget {
  @override
  _ResetCodeSentScreenState createState() => _ResetCodeSentScreenState();
}

class _ResetCodeSentScreenState extends State<ResetCodeSentScreen> {
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
      appBar: AppTopBar(title: 'Code de réinitialisation envoyé'),
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
                  AppTitle(text: 'Code de réinitialisation envoyé'),
                  AppSubtitle(
                      text: 'Veuillez entrer le code que nous avons envoyé à votre adresse e-mail.'),
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
                  SizedBox(height: 50),
// Inside the _ResetCodeSentScreenState class
                  AppElevatedButton(
                    onPressed: () {
                      // Add logic to verify the entered code
                      String verificationCode = controllers
                          .map((controller) => controller.text)
                          .join();
                      print('Code saisi: $verificationCode');

                      // Navigate to the ResetPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPage()),
                      );
                    },
                    label: 'VÉRIFIER LE CODE',
                  ),

                  SizedBox(height: 20),
                  AppElevatedButton(
                    onPressed: () {},
                    label: 'RENVOYER',
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
