import 'package:bennet_eddar_app/widgets/button_widget.dart';
import 'package:bennet_eddar_app/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';


class ProfileInfos extends StatefulWidget {
  ProfileInfos({Key? key}) : super(key: key);

  @override
  _ProfileInfosState createState() => _ProfileInfosState();
}

class _ProfileInfosState extends State<ProfileInfos> {
  TextEditingController fullNameController =
      TextEditingController(text: 'nom');
  TextEditingController emailAddressController =
      TextEditingController(text: 'nom@example.com');
  TextEditingController phoneNumberController =
      TextEditingController(text: '123456789');

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: OrgAppTopBar(title: 'INFORMATIONS DU PROFILE' ,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'NOM COMPLET',
                style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w300,
                  ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01), 
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(0, 225, 220, 220),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'ADRESSE E-MAIL',
                style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w300,
                  ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: emailAddressController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01), 
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(0, 225, 220, 220),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'NUMERO DE TELEPHONE',
                style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w300,
                  ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01), 
                ),
              ),
              SizedBox(height: screenHeight * 0.2),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: () {
                      
                    },
                    label: "APPLIQUER",
                  ),
                ),
              ),
              const SizedBox(height: 20), 
            ],
          ),
        ),
      ),
    );
  }
}
