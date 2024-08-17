import 'package:flutter/material.dart';
import '../../commons/colors.dart';
import '../../commons/styles.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  AppElevatedButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            AppColors.accentColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(235, 44),
        maximumSize: const Size(235, 44),
      ),
      child: Center(
        child: Text(
          label,
          style:  AppFonts.buttonTextStyle,
        ),
      ),
    );
  }
}