import 'package:bennet_eddar_cook/screens/SignUp/signUpVerifyPhoneNumber.dart';
import 'package:flutter/material.dart';
import '../../widgets/top_bar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/title_subtitle_widget.dart';
import '../../widgets/phone_number_input_field_widget.dart';


class SignUpScreenPhoneNumber extends StatefulWidget {
  final String selectedLocation;

   SignUpScreenPhoneNumber({super.key, required this.selectedLocation});
   

  @override
  _SignUpScreenPhoneNumberState createState() => _SignUpScreenPhoneNumberState();
}

class _SignUpScreenPhoneNumberState extends State<SignUpScreenPhoneNumber> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isPhoneNumberValid = false;
  

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const AppTopBar(title: 'Commencez avec Benet Eddar'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTitle(text: 'Commencez avec Bennet Eddar - Portail Du Chef'),
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
                  Text(
                    'Selected Location: ${widget.selectedLocation}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppPhoneNumberTextField(
                    controller: _phoneNumberController,
                    onPhoneNumberChanged: (isValid) {
                      setState(() {
                        _isPhoneNumberValid = isValid;
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
            AppElevatedButton(
  onPressed: _isPhoneNumberValid 
    ? () {
        String phoneNumber = _phoneNumberController.text;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyPhoneNumberScreen(
              location: widget.selectedLocation,
              phoneNumber: '+213$phoneNumber',
            ),
          ),
        );
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
}
