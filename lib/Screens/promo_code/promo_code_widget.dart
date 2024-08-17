import 'package:bennet_eddar_app/commons/colors.dart';
import 'package:flutter/material.dart';
import 'promo_code_model.dart';

class PromoCodeWidget extends StatelessWidget {
  final String name;
  final int percentage;
  final Function(PromoCode) onPressed;

  PromoCodeWidget({required this.name, required this.percentage, required this.onPressed});

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
          Text(
            '$name - $percentage%',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              // Invoke the onPressed callback with the selected promo code
              onPressed(PromoCode(name: name, percentage: percentage));
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Apply' , style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
