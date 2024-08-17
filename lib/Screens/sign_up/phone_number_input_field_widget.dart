import 'package:flutter/material.dart';
import '../../commons/colors.dart';
import '../../commons/images.dart';



class AppPhoneNumberTextField extends StatefulWidget {
  @override
  _AppPhoneNumberTextFieldState createState() => _AppPhoneNumberTextFieldState();
}

class _AppPhoneNumberTextFieldState extends State<AppPhoneNumberTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'NUMÉRO DE TÉLÉPHONE',
        prefixIcon: Image.asset(algeria_flag_image, width: 10, height: 10),
        prefixText: '+213 ',
        counterText: '',
        errorText: !_validatePhoneNumber(_controller.text) ? 'Numéro invalide' : null,
        errorStyle: const TextStyle(fontSize: 12), 
        enabledBorder: OutlineInputBorder(
          borderSide:const BorderSide(color: const Color.fromARGB(255, 64, 63, 63)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLength: 9, // 3 digits for the country code, 9 digits for the phone number, and 2 spaces
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  bool _validatePhoneNumber(String phoneNumber) {
    // You may use regex or other criteria
    return phoneNumber.isNotEmpty && phoneNumber.length == 9;
  }
}