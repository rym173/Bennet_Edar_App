import 'package:flutter/material.dart';


class AppTextField extends StatefulWidget {
  final String label;
  final bool isObscure;

  const AppTextField({super.key, required this.label, this.isObscure = false});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: widget.isObscure && !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: widget.label == 'E-MAIL ADDRESS' &&
                !_validateEmail(_controller.text)
            ? 'Invalid email'
            : widget.label == 'PASSWORD' && !_validatePassword(_controller.text)
                ? 'Invalid password'
                : null,
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
    );
  }

  bool _validateEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }
}