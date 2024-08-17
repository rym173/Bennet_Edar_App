import 'package:flutter/material.dart';
import '../commons/colors.dart';


class InputSquare extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const InputSquare({super.key, 
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.BorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) {
          // Move focus to the next square when the user enters a digit
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else {
            // Move focus to the previous square when the user deletes a digit
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}