import 'package:bennet_eddar_app/screens/sign_up/SignUpSuccessful.dart';
import 'package:bennet_eddar_app/widgets/button_widget.dart';
import 'package:bennet_eddar_app/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/widgets/custom_input_field.dart';
import 'package:bennet_eddar_app/widgets/title_subtitle_widget.dart';
import 'package:flutter/gestures.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppTopBar(title: 'S\'inscrire'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTitle(text: 'Créer un compte'),
              RichText(
                text: TextSpan(
                  text: 'Veuillez renseigner votre nom, votre adresse e-mail et votre mot de passe pour vous inscrire. ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Yaldevi',
                    fontSize: 16,
                    color: Color(0xFF6C6C6C),
                  ),
                  children: [
                    TextSpan(
                      text: 'Avez-vous déjà un compte?',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Yaldevi',
                        fontSize: 16,
                        color: Color(0xFFFFB261),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                         Navigator.of(context).popUntil((route) => route.isFirst);

                          print('Avez-vous déjà un compte? clicked');
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomInputField(
                labelText: 'NOM COMPLET',
                hintText: 'Entrer votre nom',
                isDense: true,
                validator: (textValue) {
                  if (textValue == null || textValue.isEmpty) {
                    return 'Indiquer votre nom!';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomInputField(
                labelText: 'ADRESSE E-MAIL',
                hintText: 'Entrer votre adresse e-mail',
                isDense: true,
                validator: (textValue) {
                  if (textValue == null || textValue.isEmpty) {
                    return 'Indiquer votre adresse e-mail!';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomInputField(
                labelText: 'MOT DE PASSE',
                hintText: 'Saisir un mot de passe',
                isDense: true,
                obscureText: true,
                validator: (textValue) {
                  if (textValue == null || textValue.isEmpty) {
                    return 'Indiquer votre mot de passe!';
                  }
                  return null;
                },
                suffixIcon: true,
              ),
              SizedBox(height: screenHeight * 0.07),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: AppElevatedButton(
                    onPressed: () {
             
                               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpSuccessful()),
                );
              },
              
                    label: "S'INSCRIRE",
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              const Center(
                child: Text(
                  'En cliquant sur S’inscrire, vous acceptez ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6C6C6C),
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'nos Conditions générales et notre Politique de confidentialité',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6C6C6C),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Conditions générales et Politique de confidentialité clicked');
                      },
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
