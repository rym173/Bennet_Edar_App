import 'package:flutter/material.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/top_bar_widget.dart';
import '../text_field_widget.dart';
import '../../../widgets/title_subtitle_widget.dart';
import 'resetCode.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppTopBar(title: 'Mot de passe oublié'),

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
                  AppTitle(text: 'Mot de passe oublié'),
                  AppSubtitle(text: 'Entrez votre numéro de téléphone et nous vous enverrons des instructions de réinitialisation.'),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextField(label: 'ADRESSE E-MAIL'),
                  SizedBox(height: 50),
                  SizedBox(height: 30),
                  AppElevatedButton(
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetCodeSentScreen()),
                      );
                    },
                    label: 'RÉINITIALISER LE MOT DE PASSE',
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
