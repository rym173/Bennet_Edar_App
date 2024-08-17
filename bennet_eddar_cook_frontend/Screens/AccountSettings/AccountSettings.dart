import 'package:bennet_eddar_cook/commons/colors.dart';
import 'package:bennet_eddar_cook/commons/styles.dart';
import 'package:bennet_eddar_cook/screens/AccountSettings/changeLocation.dart';
import 'package:bennet_eddar_cook/screens/promo_code/promoCodeAddPage.dart';
import 'package:bennet_eddar_cook/utils/userAuthentication.dart';
import 'package:bennet_eddar_cook/widgets/org_top_bar_without_arrow.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_cook/screens/AccountSettings/ChangePassword.dart';
import 'package:bennet_eddar_cook/screens/AccountSettings/ProfileInfos.dart';

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
    return Scaffold(
      appBar: const OrgAppTopBarNoArrw(
          title: 'PARAMETRE DU COMPTE', automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Informations du Profil',
                    style: AppFonts.SeetingName),
                subtitle: const Text('Modifiez vos informations de compte.',
                    style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileInfos()),
                  );
                },
              ),
              ListTile(
                title: const Text('Changer le Mot de Passe',
                    style: AppFonts.SeetingName),
                subtitle: const Text('Changez votre mot de passe',
                    style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.lock),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()),
                  );
                },
              ),
              ListTile(
                title: const Text('Localisation', style: AppFonts.SeetingName),
                subtitle: const Text('Ajoutez ou supprimez votre Localisation',
                    style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.location_on),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const changeLocation()),
                  );
                },
              ),
              const Divider(),
              const Text('NOTIFICATIONS', style: AppFonts.Seetinglabel),
              const SizedBox(height: 12),
              ListTile(
                title: const Text(
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
                  activeTrackColor: const Color(0xFFFFB261),
                  activeColor: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
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
                  activeTrackColor: const Color(0xFFFFB261),
                  activeColor: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
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
                  activeTrackColor: const Color(0xFFFFB261),
                  activeColor: Colors.white,
                ),
              ),
              const Divider(),
              const Text('CODES PROMO', style: AppFonts.Seetinglabel),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Ajouter un code promo',
                    style: AppFonts.SeetingName),
                subtitle: const Text(
                    'Appuyez si vous souhaitez ajouter un code promo.',
                    style: AppFonts.SeetingDescription),
                leading: const Icon(Icons.card_giftcard_rounded),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PromoCodeAddPage()),
                  );
                },
              ),
              const Divider(),
              const Text('PLUS', style: AppFonts.Seetinglabel),
              const SizedBox(height: 12),
              ListTile(
                title: const Text('Évaluez-nous', style: AppFonts.SeetingName),
                leading: const Icon(Icons.star, color: Color(0xFFFFB261)),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // Implement logic
                },
              ),
              ListTile(
                title: const Text('FAQ', style: AppFonts.SeetingName),
                subtitle: const Text('Foire aux questions',
                    style: AppFonts.SeetingDescription),
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
                  
                   
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Déconnexion'),
                          content: Text(
                              'Êtes-vous sûr de vouloir vous déconnecter ?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Annuler',style: TextStyle(color: AppColors.accentColor)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Confirmer',
                                  style: TextStyle(color: AppColors.accentColor)),
                              onPressed: () {
                                UserAuthentication.logout(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
