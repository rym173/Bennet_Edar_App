import 'package:flutter/material.dart';
import '../../commons/colors.dart';

class AppLink extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  AppLink({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: MouseRegion(
          cursor: onPressed != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: Text(
            text,
            style: TextStyle(
              color: onPressed != null
                  ? AppColors.primaryColor
                  : AppColors.bodyTextColor,
              fontSize: 14,
              fontFamily: 'Yaldevi',
              fontWeight: FontWeight.w300,
              height: 0.14,
              letterSpacing: -0.24,
              decoration: onPressed != null
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
