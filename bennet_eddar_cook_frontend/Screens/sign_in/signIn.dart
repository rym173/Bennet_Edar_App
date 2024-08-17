import 'package:flutter/material.dart';
import '../../widgets/BottomBar.dart';
import '../../widgets/top_bar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/title_subtitle_widget.dart';
import 'text_field_widget.dart';
import 'link_text_widget.dart';
import 'forget_password/forgetPassword.dart';
import '../LocationIdentification/EnterLocation.dart';
import 'package:bennet_eddar_cook/utils/userAuthentication.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press
        // Return false to disable the back button
        return false;
      },
      child: Scaffold(
        appBar: const AppTopBar(title: 'Se Connecter', automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child:  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTitle(text: 'Bienvenue sur Benet Eddar -Portail du Chef '),
                      SizedBox(height: 20),
                      AppSubtitle(
                        text: 'Entrez votre adresse e-mail pour vous connecter.',
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextField(
                        label: 'ADRESSE E-MAIL',
                        controller: emailController,
                        validationText: isEmailValid ? '' : 'Email invalide',
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'MOT DE PASSE',
                        isObscure: true,
                        controller: passwordController,
                        validationText: isPasswordValid ? '' : 'Mot de passe invalide',
                      ),
                      const SizedBox(height: 40),
                      AppLink(
                        text: 'Mot de passe oublié ?',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPasswordScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                      AppElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEmailValid = _validateEmail(emailController.text);
                            isPasswordValid = _validatePassword(passwordController.text);
                          });

                          if (isEmailValid && isPasswordValid) {
                            // Call the function to handle sign-in with the server
                            _handleSignIn();
                          }
                        },
                        label: 'SE CONNECTER',
                      ),
                      const SizedBox(height: 50),
                      AppLink(
                        text: "Vous n'avez pas de compte ? Créez un nouveau compte",
                        onPressed: () {
                          // Navigate to the "Create Account" page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EnterLocation(),
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

  void _handleSignIn() async {
    // Call the authentication function to sign in the user
    String result = await UserAuthentication.loginUser(
        emailController.text, passwordController.text);

    if (result != 'success') {
      // Handle the error case
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ou mot de passe incorrect'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error during sign-in: $result');
      // You can show an error message to the user
      // For example, set it to a variable and display it in the UI
    } else {
      // If sign-in is successful, navigate to the desired screen
     Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomBar()),
          );
    }
  }

  bool _validateEmail(String email) {
    // Email validation using regex
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

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
