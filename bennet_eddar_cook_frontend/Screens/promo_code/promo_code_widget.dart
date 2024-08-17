import 'package:flutter/material.dart';


class PromoCodeWidget extends StatelessWidget {
  final String name;
  final int percentage;
  final String validity;

  const PromoCodeWidget({super.key, 
    required this.name,
    required this.percentage,
    required this.validity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name - $percentage%',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                'Validity: $validity hours',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Container(
            
            
            child: Text(
              isValid(validity) ? 'VALID' : 'EXPIRED',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  bool isValid(String validity) {
    // Implement your logic to check the validity and return a boolean
    // For example, you can compare with the current date or time
    // If valid, return true; otherwise, return false
    // Replace this with your actual validity checking logic
    return true;
  }
}
