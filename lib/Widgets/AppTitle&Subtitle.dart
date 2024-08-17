import 'package:flutter/material.dart';
import '../../commons/colors.dart';


class AppTitle extends StatelessWidget {
  final String text;

  AppTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 338,
      height: 80,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 36,
          fontFamily: 'Yaldevi',
          fontWeight: FontWeight.w300,
          height: 1.0, // Adjusted line height to improve readability
          letterSpacing: 0.22,
        ),
        softWrap: true, // Enable soft wrapping
      ),
    );
  }
}

class AppSubtitle extends StatelessWidget {
  final String text;

  AppSubtitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 338,
      height: 50, 
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.bodyTextColor,
          fontSize: 18,
          fontFamily: 'Yaldevi',
          fontWeight: FontWeight.w500,
          height: 1.0, 
          letterSpacing: 0.22,
        ),
        softWrap: true, 
      ),
    );
  }
}