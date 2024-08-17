import 'package:bennet_eddar_app/widgets/button_widget.dart';
import 'package:bennet_eddar_app/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';


class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool currentPasswordVisible = true;
  bool newPasswordVisible = true;
  bool confirmNewPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: OrgAppTopBar(title: 'CHANGER LE MOT DE PASSE',),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.04),
              const Text(
                'MOT DE PASSE ACTUEL',
                style: TextStyle(
                    color: Color(0xFF6C6C6C),
                   
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w300,
                  ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: currentPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(0, 225, 220, 220)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      currentPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Color.fromARGB(255, 99, 99, 99),
                      size: screenHeight * 0.024,
                    ),
                    onPressed: () {
                      setState(() {
                        currentPasswordVisible = !currentPasswordVisible;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              const Text(
                'NOUVEAU MOT DE PASSE',
                style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w300,
                  ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: newPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(0, 225, 220, 220)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      newPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Color.fromARGB(255, 99, 99, 99),
                      size: screenHeight * 0.024,
                    ),
                    onPressed: () {
                      setState(() {
                        newPasswordVisible = !newPasswordVisible;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              const Text(
                'CONFIRMER LE NOUVEAU MOT DE PASSE',
                style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w300,
                  ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: confirmNewPasswordVisible,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(0, 225, 220, 220)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      confirmNewPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Color.fromARGB(255, 99, 99, 99),
                      size: screenHeight * 0.024,
                    ),
                    onPressed: () {
                      setState(() {
                        confirmNewPasswordVisible = !confirmNewPasswordVisible;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.2),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: () {
                      // Implement logic
                    },
                    label: "APPLIQUER",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
