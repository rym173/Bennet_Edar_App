import 'package:bennet_eddar_cook/screens/AccountSettings/ProfileInfos.dart';
import 'package:bennet_eddar_cook/screens/AccountSettings/changeLocation.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';
import '../sign_in/text_field_widget.dart';
import '../../commons/colors.dart';
import '../../widgets/button_widget.dart';
import 'build_link_widget.dart';
import '../gallery/cookGallery.dart';
import '../../commons/images.dart';
import'../promo_code/promoCodeAddPage.dart';
import 'package:http/http.dart' as http;


class EditProfileScreen extends StatelessWidget {
  final VoidCallback onSave;
  const EditProfileScreen({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    TextEditingController nomUtilisateurController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    return Scaffold(
      appBar: const OrgAppTopBar(title: 'Edit Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20.0),
            // "CHANGE PROFILE" link
            const Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage(cook_image), // Replace with your image
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                // Handle the "CHANGE PROFILE" link tap
              },
              child: const Center(
                child: Text(
                  'CHANGER LA PHOTO DE PROFILE',
                  style: TextStyle(
                    color: AppColors.accentColor, // Use your active color
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // AppTextField for User Name
             AppTextField(
              label: 'NOM DUTILISATEUR',
              controller: nomUtilisateurController,
            ),
            const SizedBox(height: 20.0),
            // AppTextField for Bio
             AppTextField(
              label: 'BIO',
              controller: bioController,
            ),
            const SizedBox(height: 20.0),
            // Space
            const SizedBox(height: 20.0),
            // Links section
            buildLink('AJOUTER UN CODE PROMO', onTap: () {
              // Navigate to CookGalleryScreen when "GALLERY" link is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PromoCodeAddPage()),
              );
            }),
            buildLink('PARAMETRES DES INFOMATIONS PERSONNELLES',  onTap: () {
              // Navigate to CookGalleryScreen when "GALLERY" link is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileInfos()),
              );
            }),
            buildLink('CHANGER LA LOCALISATION',  onTap: () {
              // Navigate to CookGalleryScreen when "GALLERY" link is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const changeLocation()),
              );
            }),
            buildLink('GALERIE', onTap: () {
              // Navigate to CookGalleryScreen when "GALLERY" link is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  CookGalleryScreen()),
              );
            }),
            const SizedBox(height: 50.0),
AppElevatedButton(
  label: 'SAUVEGARDER',
  onPressed: () async {
    // Get the values from text fields
                String nomUtilisateur = nomUtilisateurController.text;
                String bio = bioController.text;

    // Check if both fields are empty
    if (nomUtilisateur.isEmpty && bio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rien a modifier'),
        ),
      );
      return; // Exit the onPressed function if both fields are empty
    }

    try {
      // Check if nom d'utilisateur is not empty and bio is empty
      if (nomUtilisateur.isNotEmpty && bio.isEmpty) {
        await updateNomUtilisateur(nomUtilisateur);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nom d\'utilisateur sauvegarde avec success'),
          ),
        );
        onSave(); // Exit the onPressed function
        Navigator.pop(context);
      }

      // Check if bio is not empty and nom d'utilisateur is empty
      if (nomUtilisateur.isEmpty && bio.isNotEmpty) {
        await updateBio(bio);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bio sauvegarde avec success'),
          ),
        );
        onSave(); // Exit the onPressed function
        Navigator.pop(context);
      }

      // Check if both nom d'utilisateur and bio are not empty
      if (nomUtilisateur.isNotEmpty && bio.isNotEmpty) {
        await updateBothFields(nomUtilisateur, bio);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Changements sauvegarde avec success'),
          ),
        );
        Navigator.pop(context);
        onSave(); // Exit the onPressed function
        
      }
    } catch (error) {
      // Handle any errors that occur during API calls
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again.'),
        ),
      );
    }
  },
),
          ],
        ),
      ),
    );
  }

Future<void> updateNomUtilisateur(String nomUtilisateur) async {
  final userID = await getUserId();
  // Replace the URL with your actual Flask endpoint for updating nom d'utilisateur
  final url = 'https://flask-cook-endpoint.vercel.app/update-nom-utilisateur/$userID';
  await http.post(Uri.parse(url), body: {'Cook_Name': nomUtilisateur});
}

Future<void> updateBio(String bio) async {
  final userID = await getUserId();
  // Replace the URL with your actual Flask endpoint for updating bio
  final url = 'https://flask-cook-endpoint.vercel.app/update-bio/$userID';
  await http.post(Uri.parse(url), body: {'Bio': bio});
}

Future<void> updateBothFields(String nomUtilisateur, String bio) async {
  final userID = await getUserId();
  // Replace the URL with your actual Flask endpoint for updating both fields
  final url = 'https://flask-cook-endpoint.vercel.app/update-both-fields/$userID';
  await http.post(Uri.parse(url), body: {'Cook_Name': nomUtilisateur, 'Bio': bio});
}
  }

