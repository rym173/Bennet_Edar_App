import 'package:flutter/material.dart';
import '../../commons/styles.dart';
import '../../commons/images.dart';
import '../../commons/colors.dart';

class OrderSuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Stack(
            alignment: Alignment.center,
            children: [
            
              Image(image: AssetImage(Icon_done), height: 80.0, width: 80.0),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            'Commande passée avec succès',
            style: AppFonts.titleAppBarTextStyle,
            softWrap: true,
          ),
          const SizedBox(height: 16.0),
          Text(
           "Vous recevrez une notification une fois que le cuisinier aura accepté votre commande. Merci d'utiliser notre service !",
            style: AppFonts.appCenteredTextTextStyle,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          const SizedBox(height: 32.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context); 
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Continuer à naviguer',
              style: TextStyle(
                color: AppColors.accentColor,
                fontFamily: 'Yaldevi',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
