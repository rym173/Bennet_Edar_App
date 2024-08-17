import 'package:flutter/material.dart';
import '../../commons/colors.dart';


  Widget buildLink(String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.accentColor, // Use your active color
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
