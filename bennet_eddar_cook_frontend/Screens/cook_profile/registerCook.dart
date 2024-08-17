import 'package:bennet_eddar_cook/constants/endpoints.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import 'package:bennet_eddar_cook/widgets/BottomBar.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';
import '../sign_in/text_field_widget.dart';
import '../../commons/colors.dart';
import '../../widgets/button_widget.dart';
import '../../commons/images.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class RegisterCookScreen extends StatefulWidget {
  RegisterCookScreen({super.key});

  @override
  _RegisterCookScreenState createState() => _RegisterCookScreenState();
}

class _RegisterCookScreenState extends State<RegisterCookScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrgAppTopBar(title: "Creer Votre Profile-Chef"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _pickImage,
              child: Center(
                child: _profileImage == null
                    ? CircleAvatar(
                        radius: 60.0,
                        backgroundImage: AssetImage(cook_profile_image),
                      )
                    : CircleAvatar(
                        radius: 60.0,
                        backgroundImage: FileImage(_profileImage!),
                      ),
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: _pickImage,
              child: const Center(
                child: Text(
                  'CHOISIR LA PHOTO DE PROFILE',
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            AppTextField(
              controller: _nameController,
              label: 'NOM DUTILISATEUR',
            ),
            const SizedBox(height: 20.0),
            AppTextField(
              controller: _bioController,
              label: 'BIO',
            ),
            const SizedBox(height: 50.0),
            AppElevatedButton(
              onPressed: action_handle_registerCook_button,
              label: "TERMINER",
            ),
          ],
        ),
      ),
    );
  }

  void action_handle_registerCook_button() async {
    try {
      // Get the userID
      final userID = await getUserId();

      // Create a map with the data to send to the Flask endpoint
      Map<String, String> data = {
        'Cook_Name': _nameController.text,
        'Bio': _bioController.text,
      };

      // Send a POST request to the Flask endpoint
      final response = await http.post(
        Uri.parse(getApiEndpointForCookRegister(userID)),
        body: data,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Handle successful response

        // Show a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inscription Terminée avec succès!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to the new page after a delay (you can adjust the duration)
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomBar()),
          );
        });
      } else {
        // Handle error response
        print('Error registering cook. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
