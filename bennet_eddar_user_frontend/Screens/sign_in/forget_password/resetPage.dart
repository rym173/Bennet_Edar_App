import 'package:flutter/material.dart';
import '../../../widgets/top_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/title_subtitle_widget.dart';
import '../text_field_widget.dart';

class ResetPage extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppTopBar(title: 'Réinitialiser le mot de passe'),
     
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
                  AppTitle(text: 'Réinitialiser le mot de passe'),
                  AppSubtitle(text: 'Entrez votre nouveau mot de passe et confirmez-le.'),
                ],
              ),
            ),
            
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextField(label: 'NOUVEAU MOT DE PASSE', isObscure: true),
                  SizedBox(height: 40),
                  AppTextField(label: 'CONFIRMER LE NOUVEAU MOT DE PASSE', isObscure: true),
                  SizedBox(height: 70),
                  AppElevatedButton(
                    onPressed: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomAppBar(),
                            ),
                          );
                      // Add logic to save the new passord
                      String newPassword = newPasswordController.text;
                      String confirmNewPassword =
                          confirmNewPasswordController.text;

                      if (newPassword == confirmNewPassword) {
                        // Passwords match, you can save the new password
                        print('Nouveau mot de passe: $newPassword');
                        // Add logic to save the new password
                      } else {
                        // Passwords do not match, show an error message
                        print('Les mots de passe ne correspondent pas');
                        // Show an error message
                      }
                    },
                    label: 'ENREGISTRER',
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
