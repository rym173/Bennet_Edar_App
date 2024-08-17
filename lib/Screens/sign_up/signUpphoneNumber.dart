import 'package:flutter/material.dart';
import '../../widgets/top_bar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/title_subtitle_widget.dart';
import 'phone_number_input_field_widget.dart';
import 'signUpVerifyPhoneNumber.dart';

class SignUpScreenPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: 'Commencez avec Benet Eddar'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTitle(text: 'Commencez avec Benet Eddar'),
                  SizedBox(height: 30),
                  AppSubtitle(text: 'Entrez votre numéro de téléphone pour utiliser Benet Eddar'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppPhoneNumberTextField(),
                  SizedBox(height: 50),
                  AppElevatedButton(
                    onPressed: () {
                      // Ajoutez la logique pour envoyer le code
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VerifyPhoneNumberScreen()),
                      );
                    },
                    label: 'CONTINUER',
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
