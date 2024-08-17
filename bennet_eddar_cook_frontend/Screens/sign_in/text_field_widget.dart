import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final bool isObscure;
  final TextEditingController? controller;
  final String validationText;

  const AppTextField({super.key, 
    required this.label,
    this.controller,
    this.isObscure = false,
    this.validationText = '',
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: widget.isObscure && !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: widget.label,
            errorText: widget.validationText.isNotEmpty ? widget.validationText : null,
            suffixIcon: widget.isObscure
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
        const SizedBox(height: 8.0), // Add some space between the text field and error message
      ],
    );
  }
}