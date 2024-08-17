// custom_dialog.dart
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String displayText;

  const CustomDialog({super.key, required this.displayText});

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: const Color(0xFFF7EDDC),
title: const Center(
  child: Icon(
    Icons.notification_important, // Replace with the desired notification icon
    color: Color(0xFFFFB261),
    size: 40.0, // Adjust the size as needed
  ),
),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 400.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                displayText,
                style: const TextStyle(
color: Color(0xFF010F07),
fontSize: 20,
fontFamily: 'Yaldevi',
fontWeight: FontWeight.w300,
height: 0,
letterSpacing: 0.44,
),),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // Add logic for 'Yes'
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFFB261),
              ),
              child: const Text('Oui', style: TextStyle(fontFamily: 'Yaldevi'  , fontSize: 18,
fontWeight: FontWeight.w200,
height: 0.08,
letterSpacing: 0.40,shadows: [
      Shadow(
        color: Colors.grey,
        offset: Offset(2, 2),
        blurRadius: 3,
      ),])),
            ),
            TextButton(
              onPressed: () {
                // Add logic for 'No'
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFFB261),
              ),
              child: const Text('Non', style: TextStyle(fontFamily: 'Yaldevi',fontSize: 18,

fontWeight: FontWeight.w200,
height: 0.08,
letterSpacing: 0.40, shadows: [
      Shadow(
        color: Colors.grey,
        offset: Offset(2, 2),
        blurRadius: 3,
      ),] )),
            ),
          ],
        ),
      ],
    );
  }
}
