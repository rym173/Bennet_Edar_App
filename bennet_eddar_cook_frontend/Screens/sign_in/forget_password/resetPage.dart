import 'dart:convert';
import 'package:bennet_eddar_cook/widgets/BottomBar.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_widget.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '../../../widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import '../../../widgets/title_subtitle_widget.dart';
class ResetPage extends StatefulWidget {
  final String phoneNumber; // Add this line
  const ResetPage({super.key, required this.phoneNumber}); // Add this line
  @override
  _ResetPageState createState() => _ResetPageState();
  
}


class _ResetPageState extends State<ResetPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
      

  String newPasswordError = '';
  String confirmPasswordError = '';

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Réinitialiser le mot de passe'),
      body: Padding(
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
                  AppTitle(text: 'Réinitialiser le mot de passe'),
                  AppSubtitle(
                    text: 'Entrez votre nouveau mot de passe et confirmez-le.',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildTextField(
                    'NOUVEAU MOT DE PASSE',
                    Icons.lock,
                    TextInputType.visiblePassword,
                    (value) {
                      setState(() {
                        newPasswordError = '';
                      });
                    },
                    true,
                    newPasswordController,
                    newPasswordError,
                  ),
                  const SizedBox(height: 40),
                  buildTextField(
                    'CONFIRMER LE NOUVEAU MOT DE PASSE',
                    Icons.lock,
                    TextInputType.visiblePassword,
                    (value) {
                      setState(() {
                        confirmPasswordError = '';
                      });
                    },
                    true,
                    confirmNewPasswordController,
                    confirmPasswordError,
                  ),
                  const SizedBox(height: 70),
                  AppElevatedButton(
                    onPressed: () {
                      actionHandleChangePasswordButton(context);
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

  Widget buildTextField(
    String hintText,
    IconData icon,
    TextInputType keyboardType,
    ValueChanged<String>? onChanged,
    bool isPassword,
    TextEditingController controller,
    String errorMessage,
  ) {
    bool hasError = errorMessage.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 65,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              color: hasError ? Colors.red : Colors.blue, // Change to your color
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.blue, // Change to your color
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword && !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                ),
              ),
              if (isPassword)
                IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.blue, // Change to your color
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }

  Future<bool> updatePasswordInDatabase(
      String phone, String newPassword) async {
        int phoneNumber = int.parse(phone.substring(1));
        print('Updating password for phone number: $phoneNumber'); 
    const apiUrl = 'http://127.0.0.1:5000/users.changePassword';
    final response = await http.put(
      Uri.parse(apiUrl),
      body: {
        'phone': phoneNumber.toString(),
        'newPassword': newPassword,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void actionHandleChangePasswordButton(BuildContext context) async {
    bool isNewPasswordValid = _validatePassword(newPasswordController.text);
    bool isConfirmNewPasswordValid = _validateConfirmPassword(
      newPasswordController.text,
      confirmNewPasswordController.text,
    );

    if (isNewPasswordValid && isConfirmNewPasswordValid) {
      // Check if the new password is the same as the old one
      if (_isNewPasswordSameAsOld(newPasswordController.text)) {
        setState(() {
          newPasswordError =
              'Nouveau mot de passe doit être différent de l\'ancien';
        });
        return;
      }

      String hashedPassword = hashPassword(
          newPasswordController.text, 'unique_salt_for_each_user');

      bool passwordUpdateSuccess =
          await updatePasswordInDatabase(widget.phoneNumber, hashedPassword);

      if (passwordUpdateSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomBar(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la mise à jour du mot de passe'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static String hashPassword(String password, String salt) {
    var bytes = utf8.encode(password + salt);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        newPasswordError = 'Password cannot be empty';
      });
      return false;
    } else if (_isNewPasswordSameAsOld(value)) {
      setState(() {
        newPasswordError =
            'nouveaumot de passe doit être différent de l\'ancien';
      });
      return false;
    }
    return true;
  }

  bool _isNewPasswordSameAsOld(String newPassword) {
    String hashedNewPassword =
        hashPassword(newPassword, 'unique_salt_for_each_user');

    // Replace this with your own logic to fetch the old hashed password
    String hashedOldPassword = fetchHashedOldPassword();

    print('newPassword: $newPassword');
    print('hashedNewPassword: $hashedNewPassword');
    print('hashedOldPassword: $hashedOldPassword');

    return hashedNewPassword == hashedOldPassword;
  }

  String fetchHashedOldPassword() {
    // Replace this with your own logic to fetch the old hashed password
    return hashPassword('old_password', 'unique_salt_for_each_user');
  }

  bool _validateConfirmPassword(String password, String confirmPassword) {
    bool passwordsMatch = (password == confirmPassword);
    setState(() {
      confirmPasswordError = passwordsMatch ? '' : 'Passwords do not match';
    });
    return passwordsMatch;
  }
}
