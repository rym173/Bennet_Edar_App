import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/commons/styles.dart';


class AppCenteredText extends StatelessWidget {
  final String text;

  const AppCenteredText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 284,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppFonts.appCenteredTextTextStyle,
      ),
    );
  }
}