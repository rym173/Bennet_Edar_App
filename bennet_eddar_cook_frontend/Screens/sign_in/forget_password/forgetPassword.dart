import 'package:bennet_eddar_cook/provider/auth_provider.dart';
import 'package:bennet_eddar_cook/widgets/phone_number_input_field_widget.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/title_subtitle_widget.dart';
import 'resetCode.dart';

class ForgetPasswordScreen extends StatefulWidget {
  

  const ForgetPasswordScreen({super.key});

  @override
  _SignUpScreenPhoneNumberState createState() => _SignUpScreenPhoneNumberState();
}

class _SignUpScreenPhoneNumberState extends State<ForgetPasswordScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isPhoneNumberValid = false;
    String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Commencez avec Benet Eddar'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Column(
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
                  
      AppPhoneNumberTextField(
        controller: _phoneNumberController,
        onPhoneNumberChanged: (isValid) {
          setState(() {
            _isPhoneNumberValid = isValid;
            errorMessage = ''; // Clear error message when the input changes
          });
        },
      ),
      const SizedBox(height: 12), 
      // Display error message under the input field
        Container(
        alignment: Alignment.centerLeft, // Align text to the left
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      ),
                  const SizedBox(height: 40),
  AppElevatedButton(
    onPressed: _isPhoneNumberValid
        ? () {
            String phoneNumber = _phoneNumberController.text;
            _checkUserAndProceed(phoneNumber);
          }
        : () {},
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
    Future<void> _checkUserAndProceed(String phoneNumber) async {
    bool userExists = await AuthService.checkUserExistence(phoneNumber);

    if (!userExists) {
      setState(() {
        errorMessage = 'Nous n\'avons pas trouvé de compte associé à ce numéro de téléphone.';
      });
    }  else {
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetCodeSentScreen(
            phoneNumber: '+213$phoneNumber',
          ),
        ),
      );
    }
  }

}
