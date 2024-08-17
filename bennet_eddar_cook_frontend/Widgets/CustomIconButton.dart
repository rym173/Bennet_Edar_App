import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFFFB261),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: Size(180, 45),
      ),
    );
  }
}