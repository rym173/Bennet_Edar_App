import 'package:flutter/material.dart';
import '../commons/colors.dart';
import '../commons/styles.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const AppElevatedButton({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
         minimumSize: Size(screenWidth * 0.9, screenHeight * 0.07),
      ),
      child: Center(
        child: Text(
          label,
          style: AppFonts.buttonTextStyle,
        ),
      ),
    );
  }
}
