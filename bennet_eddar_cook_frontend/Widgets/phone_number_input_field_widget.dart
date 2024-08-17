import 'package:flutter/material.dart';
import '../commons/colors.dart';
import '../commons/images.dart';

class AppPhoneNumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(bool)? onPhoneNumberChanged;

  const AppPhoneNumberTextField({super.key, required this.controller, this.onPhoneNumberChanged});

  @override
  _AppPhoneNumberTextFieldState createState() => _AppPhoneNumberTextFieldState();
}

class _AppPhoneNumberTextFieldState extends State<AppPhoneNumberTextField> {

  // ignore: unused_field
  bool _isPhoneNumberValid = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'NUMÉRO DE TÉLÉPHONE',
        prefixIcon: Image.asset(algeria_flag_image, width: 10, height: 10),
        prefixText: '+213 ',
        counterText: '',
        errorText: !_validatePhoneNumber(widget.controller.text) ? 'Numéro invalide' : null,
        errorStyle: const TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 64, 63, 63)),
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
        bool isValid = _validatePhoneNumber(value);
        setState(() {
          _isPhoneNumberValid = isValid;
        });

        // If the onPhoneNumberChanged callback is provided, call it with the validity status
        if (widget.onPhoneNumberChanged != null) {
          widget.onPhoneNumberChanged!(isValid);
        }
      },
    );
  }

  bool _validatePhoneNumber(String phoneNumber) {
    // You may use regex or other criteria
    return phoneNumber.isNotEmpty && phoneNumber.length == 9 && (phoneNumber.startsWith('5') || phoneNumber.startsWith('6') || phoneNumber.startsWith('7')) && int.tryParse(phoneNumber) != null;
  }
}
