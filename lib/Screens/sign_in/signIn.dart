import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/widgets/BottomBar.dart';
import '../../widgets/top_bar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/title_subtitle_widget.dart';
import 'text_field_widget.dart';
import 'link_text_widget.dart';
import 'forget_password/forgetPassword.dart';
import '../LocationIdentification/EnterLocation.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = true;
  bool isPasswordValid = true;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press
        // Return false to disable the back button
        return false;
      },
      child: Scaffold(
        appBar: AppTopBar(title: 'Se Connecter', automaticallyImplyLeading: false),

        
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTitle(text: 'Bienvenue sur Benet Eddar !'),
                      SizedBox(height: 20),
                      AppSubtitle(
                        text:
                            'Entrez votre adresse e-mail pour vous connecter. Profitez de vos repas :)',
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextField(label: 'ADRESSE E-MAIL'),
                      SizedBox(height: 20),
                      AppTextField(label: 'MOT DE PASSE', isObscure: true),
                      SizedBox(height: 40),
                      AppLink(
                        text: 'Mot de passe oublié ?',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                      AppElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEmailValid =
                                _validateEmail(emailController.text);
                            isPasswordValid =
                                _validatePassword(passwordController.text);
                          });

                          print('Email valide: $isEmailValid');
                          print('Mot de passe valide: $isPasswordValid');

                          if (isEmailValid && isPasswordValid) {
                             Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BottomBar()),
                        );
                          }
                        },
                        label: 'SE CONNECTER',
                      ),
                      SizedBox(height: 30),
                      const Text(
                        "Vous n'avez pas de compte ?",
                        style: TextStyle(
                          fontSize: 14.0, 
                          color: Colors.black, 
                        ),
                      ),
                      SizedBox(height: 10,),
                      AppLink(
                        text: "Créez un nouveau compte",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EnterLocation(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateEmail(String email) {
    // Email validation using regex
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // Allow an empty string or validate with the regex
    bool isValid = email.isEmpty || emailRegex.hasMatch(email);

    print('Email validation result for "$email": $isValid');
    return isValid;
  }

  bool _validatePassword(String password) {
    // Simple password validation example
    // Allow an empty string or validate based on length
    bool isValid = password.isEmpty || password.length >= 6;

    print('Password validation result for "$password": $isValid');
    return isValid;
  }
}