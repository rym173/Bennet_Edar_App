import 'package:bennet_eddar_app/commons/styles.dart';
import 'package:bennet_eddar_app/screens/LocationIdentification/EnterLocation.dart';
import 'package:bennet_eddar_app/screens/promo_code/promoCodeScreen.dart';
import 'package:bennet_eddar_app/widgets/org_top_bar_without_arrow.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/screens/AccountSettings/ChangePassword.dart';
import 'package:bennet_eddar_app/screens/AccountSettings/ProfileInfos.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool pushNotifications = true;
  bool smsNotifications = true;
  bool promoNotifications = true;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: OrgAppTopBarNoArrw(title: 'PARAMETRE DU COMPTE', automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Informations du Profil', style: AppFonts.SeetingName),
                subtitle: const Text('Modifiez vos informations de compte.' , style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileInfos()),
                  );
                },
              ),
              ListTile(
                title: const Text('Changer le Mot de Passe' , style: AppFonts.SeetingName),
                subtitle: const Text('Changez votre mot de passe', style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.lock),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword()),
                  );
                },
              ),
              ListTile(
                title: const Text('Localisation' , style: AppFonts.SeetingName),
                subtitle: const Text('Ajoutez ou supprimez votre Localisation' , style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.location_on),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EnterLocation()),
                );
                },
              ),
              const Divider(),
              const Text(
                'NOTIFICATIONS', style: AppFonts.Seetinglabel
              ),
              SizedBox(height: 12),

              ListTile(
                title: Text(
                  'Notifications Push',
                  style: AppFonts.SeetingName,
                ),
                subtitle: const Text(
                  "Pour recevoir des mises à jour quotidiennes.",
                  style: AppFonts.SeetingDescription,
                ),
                leading: const Icon(Icons.notifications),
                trailing: Switch(
                  value: pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      pushNotifications = value;
                    });
                    // Implement logic
                  },
                  activeTrackColor: Color(0xFFFFB261),
                  activeColor: Colors.white,
                ),
              ),
              ListTile(
                title: Text(
                  'Notifications SMS',
                  style: AppFonts.SeetingName,
                ),
                leading: const Icon(Icons.notifications),
                trailing: Switch(
                  value: smsNotifications,
                  onChanged: (value) {
                    setState(() {
                      smsNotifications = value;
                    });
                    // Implement logic
                  },
                  activeTrackColor: Color(0xFFFFB261),
                  activeColor: Colors.white,
                ),
              ),
              ListTile(
                title: Text(
                  'Notifications Promotionnelles',
                  style: AppFonts.SeetingName,
                ),
                leading: const Icon(Icons.notifications),
                trailing: Switch(
                  value: promoNotifications,
                  onChanged: (value) {
                    setState(() {
                      promoNotifications = value;
                    });
                    // Implement logic
                  },
                  activeTrackColor: Color(0xFFFFB261),
                  activeColor: Colors.white,
                ),
              ),
              const Divider(),
               const Text(
                'CODES PROMO', style: AppFonts.Seetinglabel
              ),
              SizedBox(height: 12),
              ListTile(
                title: const Text('Promotions et offres' , style: AppFonts.SeetingName),
                subtitle: const Text('Appuyez si vous souhaitez voir les offres et les codes promotionnels', style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.card_giftcard_rounded),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PromoCodePage()),
                );
                },
              ),
              const Divider(),
              const Text(
                'PLUS', style: AppFonts.Seetinglabel
              ),
              SizedBox(height: 12),
              ListTile(
                title: const Text('Évaluez-nous', style: AppFonts.SeetingName),
                leading: const Icon(Icons.star, color: Color(0xFFFFB261)),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // Implement logic
                },
              ),
              ListTile(
                title: const Text('FAQ' , style: AppFonts.SeetingName),
                subtitle: const Text('Foire aux questions', style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.book),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // Implement logic
                },
              ),
              ListTile(
                title: const Text('Déconnexion', style: AppFonts.SeetingName),
                leading: const Icon(Icons.logout_outlined),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // Implement logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
