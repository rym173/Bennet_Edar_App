import 'package:flutter/material.dart';
import '../commons/colors.dart';

class AppTitle extends StatelessWidget {
  final String text;

  const AppTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.9, // Adjusted width to 90% of screen width
      height: screenHeight * 0.1, // Adjusted height to 10% of screen height
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: screenWidth * 0.07, // Adjusted font size based on screen width
          fontFamily: 'Yaldevi',
          fontWeight: FontWeight.w300,
          letterSpacing: 0.22,
        ),
        softWrap: true,
      ),
    );
  }
}

class AppSubtitle extends StatelessWidget {
  final String text;

  const AppSubtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9, // Adjusted width to 90% of screen width
      height: MediaQuery.of(context).size.height * 0.07, // Adjusted height to 7% of screen height
      child: Text(
        text,
        style:  TextStyle(
          color: AppColors.bodyTextColor,
          fontSize: screenWidth * 0.04, // Adjusted font size based on screen width
          fontFamily: 'Yaldevi',
          fontWeight: FontWeight.w500,
          height: 1.2,
          letterSpacing: 0.22,
        ),
        softWrap: true,
      ),
    );
  }
}
