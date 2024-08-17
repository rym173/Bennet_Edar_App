import 'package:bennet_eddar_cook/provider/auth_provider.dart';
import 'package:bennet_eddar_cook/screens/sign_in/signIn.dart';
import 'package:bennet_eddar_cook/widgets/title_subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_cook/screens/SignUp/SignUpSuccessful.dart';
import 'package:bennet_eddar_cook/widgets/button_widget.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_widget.dart';
import 'package:bennet_eddar_cook/widgets/custom_input_field.dart';
import 'package:bennet_eddar_cook/utils/userAuthentication.dart';
import 'package:flutter/gestures.dart';

class SignUp extends StatefulWidget {
  final String location;
  final String phoneNumber;

  const SignUp({super.key, required this.location, required this.phoneNumber});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _tx_name_controller = TextEditingController();
  final TextEditingController _tx_email_controller = TextEditingController();
  final TextEditingController _tx_pass_controller = TextEditingController();

  String? emailError;
  String? passwordError;
  String? nameError;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(title: "S'inscrire"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTitle(text: 'Créer un compte'),
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
                               Navigator.push(
                                   context,
                                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                              );
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomInputField(
                controller: _tx_name_controller,
                labelText: 'NOM COMPLET',
                hintText: 'Entrer votre nom',
                isDense: true,
                errorText: nameError,
                validator: (textValue) {
                  if (textValue == null || textValue.isEmpty || textValue.length < 6) {
                    return 'Indiquer votre nom complet!';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomInputField(
                controller: _tx_email_controller,
                labelText: 'ADRESSE E-MAIL',
                hintText: 'Entrer votre adresse e-mail',
                isDense: true,
                errorText: emailError,
                validator: (textValue) {
                  if (textValue == null || textValue.isEmpty) {
                    return 'Indiquer votre adresse e-mail!';
                  }
                  else if (!textValue.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
                    return 'Adresse e-mail non valide!';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              CustomInputField(
                controller: _tx_pass_controller,
                labelText: 'MOT DE PASSE',
                hintText: 'Saisir un mot de passe',
                isDense: true,
                obscureText: true,
                errorText: passwordError,
                validator: (textValue) {
                  if (textValue == null || textValue.isEmpty || textValue.length < 6) {
          
                    return 'Indiquer un mot de passe d\'au moins 6 characteres!';
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
                      action_handle_signup_button();
                    },
                    label: isLoading ? 'Chargement...' : "S'INSCRIRE",
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

  void action_handle_signup_button() async {
    String location = widget.location;
    String phoneNumber = widget.phoneNumber;

    setState(() {
      isLoading = true;
      emailError = null;
      passwordError = null;
    });

    String result = await UserAuthentication.signupUser({
      'name': _tx_name_controller.text.trim(), 
      'email': _tx_email_controller.text,
      'password': _tx_pass_controller.text,
      'location': location,
      'phone': phoneNumber,
    });

    setState(() {
      isLoading = false;
    });

    if (result != 'success') {
      setState(() {
        if (result.contains('User already exists')) {
          emailError = 'Email existe deja';
        }

        if (result.contains('Password')) {
          passwordError = 'Mot de passe n\'est pas valide';
        }
                if (result.contains('Name')) {
          // Handle the case where Name is empty
          nameError = 'Nom ne peut pas être vide';
        }
      });
    } else {
      await AuthService.addUserToFirestore(phoneNumber);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpSuccessful()),
      );
    }
  }
}
