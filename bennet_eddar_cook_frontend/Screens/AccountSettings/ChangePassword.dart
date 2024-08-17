import 'package:bennet_eddar_cook/utils/Settings.dart';
import 'package:bennet_eddar_cook/utils/userAuthentication.dart';
import 'package:bennet_eddar_cook/widgets/button_widget.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/user_info.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool currentPasswordVisible = true;
  bool newPasswordVisible = true;
  bool confirmNewPasswordVisible = true;
  late int cookID;
  late TextEditingController _currentPassword;
  late TextEditingController _newPassword;
  late TextEditingController _confNewPassword;
  late String currentPassword;
  late String newPassword;
  bool isLoading = true;

  Future<void> getPassword() async {
    currentPassword = await getUserPassword();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPassword();
    _currentPassword = TextEditingController();
    _newPassword = TextEditingController();
    _confNewPassword = TextEditingController();
    CookID();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const OrgAppTopBar(
        title: 'CHANGER LE MOT DE PASSE',
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFB261)))
              : Column(
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
                            child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            obscureText: currentPasswordVisible,
                            controller: _currentPassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.005),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(0, 225, 220, 220)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez inserer le mot de passe actuel.';
                              }
                              return null;
                            },
                          ),
                        )),
                        IconButton(
                          icon: Icon(
                            currentPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromARGB(255, 99, 99, 99),
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
                            child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            obscureText: newPasswordVisible,
                            controller: _newPassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.005),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(0, 225, 220, 220)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez inserer le nouveau mot de passe .';
                              } else if (value.length < 6) {
                                return 'Indiquer un mot de passe d\'au moins 6 characteres!';
                              }
                              return null;
                            },
                          ),
                        )),
                        IconButton(
                          icon: Icon(
                            newPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromARGB(255, 99, 99, 99),
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
                            child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            obscureText: confirmNewPasswordVisible,
                            controller: _confNewPassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.005),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(0, 225, 220, 220)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez confirmer le nouveau mot de passe .';
                              } else if (value != _newPassword.text) {
                                return 'La confirmation ne correspond pas au nouveau mot de passe';
                              }
                              return null;
                            },
                          ),
                        )),
                        IconButton(
                          icon: Icon(
                            confirmNewPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromARGB(255, 99, 99, 99),
                            size: screenHeight * 0.024,
                          ),
                          onPressed: () {
                            setState(() {
                              confirmNewPasswordVisible =
                                  !confirmNewPasswordVisible;
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
                          onPressed: () async {
                            String currentPwd = UserAuthentication.hashPassword(
                                _currentPassword.text,
                                'unique_salt_for_each_user');
                            if (currentPwd != currentPassword) {
                              print('$currentPwd : $currentPassword');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Mot de passe invalide.'),
                                ),
                              );
                            } else if (_newPassword.text.isEmpty ||
                                _newPassword.text.length < 6 ||
                                _confNewPassword.text.isEmpty ||
                                _confNewPassword.text != _newPassword.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Veuillez fournir un mot de passe valide.'),
                                ),
                              );
                            } else {
                              print('is changing');
                              newPassword = _newPassword.text;
                              setState(() {
                                isLoading = true;
                              });
                              bool answer = await changePassword();
                              print('got answer');

                              if (answer) {
                                // Une fois le mot de passe changé, affichez le SnackBar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Mot de passe changé avec succès'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                setState(() {
                                  isLoading = false;
                                  Navigator.pop(context);
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Erreur lors de la modification des informations.Veuillez réessayer plus tard.'),
                                  ),
                                );
                              }
                            }
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

  Future<bool> changePassword() async {
    await modifyUserPassword(newPassword);

    await Settings.updatePassword(cookID, newPassword);

    return true;
  }

  Future<void> CookID() async {
    String? userID = await getUserId();
    if (userID != null) {
      cookID = int.parse(userID);
    } else {
      print('error getting user id');
    }
  }
}
