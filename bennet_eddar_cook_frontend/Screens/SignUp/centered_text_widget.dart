import 'package:flutter/material.dart';
import 'package:bennet_eddar_cook/commons/styles.dart';

class AppCenteredText extends StatelessWidget {
  final String text;

  const AppCenteredText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 284,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppFonts.appCenteredTextTextStyle,
      ),
    );
  }
}
