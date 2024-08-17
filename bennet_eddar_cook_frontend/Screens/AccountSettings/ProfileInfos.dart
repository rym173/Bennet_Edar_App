import 'package:bennet_eddar_cook/widgets/button_widget.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/user_info.dart';
import '../../utils/Settings.dart';
class ProfileInfos extends StatefulWidget {
  const ProfileInfos({Key? key}) : super(key: key);

  @override
  _ProfileInfosState createState() => _ProfileInfosState();
}

class _ProfileInfosState extends State<ProfileInfos> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailAddressController;
  late TextEditingController _phoneNumberController;
  late String userName = '';
  late String userEmail = '';
  late String userPhoneNumber = '';
  bool isLoading = true;
  late int cookID;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailAddressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    fillData();
    CookID();
    
  }

  Future<void> fillData() async {
    if (_fullNameController.text.isEmpty){
      userName = await getUserName();
    }else{
      userName = _fullNameController.text;
    } 
    
    if (_emailAddressController.text.isEmpty){
      userEmail = await getUserEmail();
    }else {
      userEmail = _emailAddressController.text; 
    }
    if(_phoneNumberController.text.isEmpty){
      int? userNumber = await getUserPhoneNumber();

      if (userNumber != null && userNumber != 0) {
        userPhoneNumber = userNumber.toString();
      }
    }else{
      userPhoneNumber = _phoneNumberController.text;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const OrgAppTopBar(title: 'INFORMATIONS DU PROFILE'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isLoading
              ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                     CircularProgressIndicator(color: Color(0xFFFFB261))
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildInfoRow('Nom Complet ', userName, _fullNameController),
                    const SizedBox(height: 20),
                    _buildInfoRow('Adresse E-mail', userEmail, _emailAddressController),
                    const SizedBox(height: 20),
                    _buildInfoRow('Numero de Telephone', userPhoneNumber, _phoneNumberController),
                    SizedBox(height: screenHeight * 0.2),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: AppElevatedButton(
                          onPressed: () async{
                            if(userName.isNotEmpty && userEmail.isNotEmpty && userPhoneNumber.isNotEmpty){
                              setState(() {
                                isLoading = true;
                              });
                              bool answer = await applyUserModifications();
                              if (answer){
                                    // Une fois les informations mises à jour, affichez le SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Informations mises à jour avec succès'),
        backgroundColor: Colors.green, // Change la couleur de fond en vert
      ),
    );
                                setState(() {
                                  
                                  isLoading = false;
                                  Navigator.pop(context);
                                });
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Erreur lors de la modification des informations.Veuillez réessayer plus tard.'),
                                  ),
                                );
                              }
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Certains champs ne sont pas remplis.'),
                                  ),
                                );
                            }
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

  Widget _buildInfoRow(String label, String value, TextEditingController controller) {
    return InkWell(
      onTap: () {
        _showInputDialog(context, label, controller).then((value) {
          setState(() {
            fillData();
          });
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6C6C6C),
              fontFamily: 'Yaldevi',
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF020202),
                  fontSize: 22,
                  fontFamily: 'Yaldevi',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              Spacer(),
              Icon(
                Icons.create_rounded,
                color: Color(0xFFFFB261),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showInputDialog(BuildContext context, String label, TextEditingController controller) async {
    await showDialog(
      context: context,
      builder: (context) {
        return _buildAlertDialogContent(label, controller);
      },
    );
  }

  Widget _buildAlertDialogContent(String label, TextEditingController controller) {
    return AlertDialog(
      title: Text(
        label,
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold,
          fontFamily: 'Yaldevi'),),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            controller: controller,
            keyboardType: label == 'Numero de Telephone'? TextInputType.phone : TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez fournir une information valide.';
              }
              return null;
            },
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.clear_outlined, color: Color.fromARGB(136, 255, 179, 97)),
        ),
        TextButton(
          onPressed: () async {
            if (controller.text.isNotEmpty) {
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ce champ ne doit pas être vide.'),
                ),
              );
            }
          },
          child: Icon(Icons.check, color: Color(0xFFFFB261)),
        ),
      ],
    );
  }

  Future <bool> applyUserModifications () async{
    await modifyUserInfos('user_name', userName);
    await modifyUserInfos('user_email', userEmail);
    await modifyUserInfos("user_phone", userPhoneNumber);
    int userPhone = int.parse(userPhoneNumber);
    await Settings.updateUserInfos(cookID,userName , userEmail , userPhone);
    
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

