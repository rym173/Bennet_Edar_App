import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final TextEditingController? controller;
  final String? errorText; // New property for validation error

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false,
    this.controller,
    this.errorText, // New property
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  late bool _showCorrectIcon;

  @override
  void initState() {
    super.initState();
    _showCorrectIcon = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontFamily: 'Yaldevi',
                color: Color(0xFF6C6C6C),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextFormField(
                controller: widget.controller,
                onChanged: (text) {
                  setState(() {
                    _showCorrectIcon = text.isNotEmpty;
                  });
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Yaldevi',
                  color: Color(0xFF010F07),
                ),
                obscureText: (widget.obscureText && _obscureText),
                decoration: InputDecoration(
                  isDense: (widget.isDense != null) ? widget.isDense : false,
                  hintText: widget.hintText,
                  errorText: widget.errorText,
                  suffixIcon: widget.suffixIcon || _showCorrectIcon
                      ? IconButton(
                          icon: _showCorrectIcon
                              ? const Icon(
                                  Icons.check,
                                  color: Color(0xFFFFB261),
                                )
                              : Icon(
                                  _obscureText
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off_outlined,
                                  color: const Color.fromARGB(133, 22, 22, 22),
                                ),
                          onPressed: () {
                            setState(() {
                              if (!_showCorrectIcon) {
                                _obscureText = !_obscureText;
                              }
                            });
                          },
                        )
                      : null,
                  suffixIconConstraints:
                      (widget.isDense != null) ? const BoxConstraints(maxHeight: 33) : null,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: widget.validator,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
