import 'package:flutter/material.dart';
import 'promo_code_widget.dart'; // Import the PromoCodeWidget
import '../promo_code/promo_code_model.dart';

class PromoCodePage extends StatelessWidget {
  final List<PromoCode> promoCodes = [
    PromoCode(name: 'CodePromo1', percentage: 10),
    PromoCode(name: 'CodePromo2', percentage: 15),
    PromoCode(name: 'CodePromo3', percentage: 25),
    PromoCode(name: 'CodePromo4', percentage: 5),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Codes Promo'),
      ),
      body: ListView.builder(
        itemCount: promoCodes.length,
        itemBuilder: (context, index) {
          PromoCode promoCode = promoCodes[index];
          return PromoCodeWidget(
            name: promoCode.name,
            percentage: promoCode.percentage,
            onPressed: (selectedPromoCode) {
              // Pass the selected promo code back to the previous screen
              Navigator.pop(context, selectedPromoCode);
            },
          );
        },
      ),
    );
  }
}
