import 'package:bennet_eddar_cook/screens/PostMenu/AddDish.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';
import '../../models/Dish.dart';
import '../../utils/Posts.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import '../../Widgets/CustomIconButton.dart';


class PostMenu extends StatefulWidget {
  const PostMenu({Key? key}) : super(key: key);

  @override
  _PostMenuState createState() => _PostMenuState();
}

class _PostMenuState extends State<PostMenu> {
  late TextEditingController _nameController;
  List<Dish> menu = [];
  late int cookID;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: OrgAppTopBar(
        title: 'PUBLIER UN MENU',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Plats ajoutés ',
                    style: TextStyle(
                      color: Color(0xFF010F07),
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Yaldevi',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.31,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          menu[index].name,
                          style: TextStyle(
                            color: Color(0xFF010F07),
                            fontSize: 18,
                            fontFamily: 'Yaldevi',
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.31,
                          ),
                        ),
                        subtitle: Text(
                          menu[index].description,
                          style: TextStyle(
                            color: Color(0xFF010F07),
                            fontSize: 16,
                            fontFamily: 'Yaldevi',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.40,
                          ),
                        ),
                        trailing: Text(
                          '${menu[index].price.toStringAsFixed(2)} DZD',
                          style: TextStyle(
                            color: Color(0xFFFFB261),
                            fontSize: 14,
                            fontFamily: 'Yaldevi',
                            fontWeight: FontWeight.bold,
                            height: 0.10,
                            letterSpacing: 0.60,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFB261),
                backgroundColor: const Color.fromARGB(133, 255, 255, 255),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05 , horizontal: screenWidth * 0.01),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              label: 'AJOUTER UN PLAT',
              icon : Icons.add,
              onPressed: () async {
                final newDish = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDish()),
                );

                if (newDish != null && newDish is Dish) {
                  setState(() {
                    menu.add(newDish);
                  });
                }
              },
            ),
            SizedBox( width: screenWidth * 0.04,),
            CustomIconButton(
              label: 'PUBLIER LE MENU',
              icon : Icons.publish,
              onPressed: () async {
                _showNameInputDialog(context);
              },
            )
          ],
        ) ,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    CookID();
  }

  Future<void> _showNameInputDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return _buildAlertDialogContent();
      },
    );
  }

  Widget _buildAlertDialogContent() {
    return AlertDialog(
      title: Text('Entrez le nom du menu'),
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Nom du menu'),
          validator: (value) {
            if(value == null || value.isEmpty){
              return 'Le nom du menu ne doit pas être vide.';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Annuler'),
        ),
        TextButton(
          onPressed: () async {
            if (_nameController != null && _nameController.text.isNotEmpty) {
              Navigator.pop(context);
              _isLoading = true;

              bool success = await _postMenu();

              if (success) {
                _isLoading = false;
                Navigator.pop(context);

                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: 'Succès',
                  text: 'Votre Menu est publié avec succès',
                  textTextStyle: TextStyle(
                    fontFamily: 'Yaldevi',
                  ),
                  backgroundColor: Colors.white,
                  confirmBtnColor: Color(0xFFFFB261),
                  confirmBtnText: 'D\'accord',
                  confirmBtnTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Yaldevi',
                  ),
                );
              }
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Veuillez remplir le nom du menu.'),
                ),
              );
            }
          },
          child: Text('Valider'),
        ),
      ],
    );
  }

  Future<bool> _postMenu() async {
    Map<String, dynamic> menuDetails = {
      'cookID': cookID,
      'name': _nameController.text,
    };

    try {
      await Posts.postMenu_Dishes(menuDetails, menu);
      print('Success: Menu posted successfully');
      return true;
    } catch (error) {
      print('Error: $error');
      return false;
    }
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
