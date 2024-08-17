import 'package:bennet_eddar_cook/utils/Posts.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_org_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'CustomDateTimeRangePicker.dart';
import '../../models/Dish.dart';
import '../../utils/imagepicker.dart';
import 'package:cool_alert/cool_alert.dart';
import 'dart:io';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import '../../Widgets/CustomIconButton.dart';

class PostDish extends StatefulWidget {
  const PostDish({super.key});
  
  @override
  _PostDishState createState() => _PostDishState();
}

class _PostDishState extends State<PostDish> {
    late TextEditingController _nameController;
    late TextEditingController _descriptionController;
    late TextEditingController _priceController;
    late DateTime _StartDate;
    late DateTime _EndDate;
    late String local_path = '';
    late int cookID;

    bool _isLoading = false;
    bool DateError = false;
    String PriceError = '';
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    CookID();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const OrgAppTopBar(
        title: 'PUBLIER UN PLAT',
      ),
      body:Stack(
        children: [
           SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      String? path = await AploadImage(
                        ImageSource.gallery,
                        context,
                      );
                      if (path != null) {
                        setState(() {
                          local_path = path;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        color: const Color(0xB7D9D9D9),
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: local_path.isEmpty
                          ? Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: screenWidth * 0.1,
                                color: Colors.white,
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                String? path = await AploadImage(
                                  ImageSource.gallery,
                                  context,
                                );
                                if (path != null) {
                                  setState(() {
                                    local_path = path;
                                  });
                                }
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.04),
                                child: Image.file(
                                  File(local_path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'NOM DU PLAT:',
                        labelStyle: TextStyle(
                          color: const Color(0xFF6C6C6C),
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      validator: (textValue) {
                        if (textValue == null || textValue.isEmpty) {
                          return 'Le nom du plat ne doit pas être vide.';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'DESCRIPTION:(Facultatif)',
                      labelStyle: TextStyle(
                        color: const Color(0xFF6C6C6C),
                        fontSize: screenWidth * 0.03,
                        fontFamily: 'Yaldevi',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    validator: (textValue){
                        return null;
                    },
                  ),
                  
                  SizedBox(height: screenHeight * 0.02),
                  CustomDateTimeRangePicker(
                    onDateTimeRangeChanged: (start, end) {
                      _StartDate = start;
                      _EndDate = end;
                      if(_StartDate.isAfter(_EndDate)){
                        DateError = true;
                      }else{
                        DateError = false;
                      }
                    },
                  ),
                  if (DateError) 
                    const Text(
                      'La date de début ne peut pas être après la date de fin.',
                      style: TextStyle(
                      color: Color.fromARGB(255, 170, 36, 27),
                      fontSize:12 ),
                    ),
                  
                  SizedBox(height: screenHeight * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price:',
                        style: TextStyle(
                          color: const Color(0xFF6C6C6C),
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.w300,
                          height: 0.14,
                          letterSpacing: 0.80,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          color: const Color(0x42F8B64C),
                          border: Border.all(color: const Color(0x42F8B64C)),
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Center(
                          child: Form( 
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.035,
                                fontFamily: 'Yaldevi',
                                fontWeight: FontWeight.w900,
                                height: 0.10,
                                letterSpacing: 0.60,
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  PriceError = "Veuillez entrer le prix";
                                  return null ;
                                }
                                PriceError = '';
                                return null;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(screenWidth * 0.02),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'DZD',
                        style: TextStyle(
                          color: const Color(0xFFFFB261),
                          fontSize: screenWidth * 0.035,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.bold,
                          height: 0.10,
                          letterSpacing: 0.60,
                        ),
                      ),
                    ],
                  ),
                  if (PriceError != '') 
                    Text(
                      PriceError,
                      style:const TextStyle(
                      color: Color.fromARGB(255, 170, 36, 27),
                      fontSize:12 ),
                    ),
                  SizedBox(height: screenHeight * 0.035),
                  CustomIconButton(
                    onPressed: () async {
                     _publishDish();
                    },
                    label: 'PUBLIER LE PLAT',
                    icon: Icons.publish,
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color:Color(0xFFFFB261) ,
                backgroundColor: const Color.fromARGB(133, 255, 255, 255),
              ),
            ),
        ],
      )
    );
  }



  Future<bool> _postDish() async {
    List <Dish> menu=[] ;
    Map<String, dynamic> menuDetails = {
        'cookID': cookID,
        'name': _nameController.text,
    };

      Dish dish = Dish(
        cookID: cookID,
        name: _nameController.text,
        description: _descriptionController.text,
        startDate: _StartDate,
        endDate: _EndDate,
        price: double.parse(_priceController.text),
        picture_Path: local_path,
      );

      menu.add(dish);


    try {
      await Posts.postMenu_Dishes(menuDetails , menu);
      print('Success: Dish posted successfully');
      return true;
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }



  Future <void> CookID () async{
    String? userID = await getUserId();
    if (userID != null){
      cookID = int.parse(userID);
    }else {
      print('error getting user id');
    }
  }



  Future<void> _publishDish() async {
    if (_nameController.text.isNotEmpty &&
        _StartDate != null &&
        _EndDate != null &&
        _priceController.text.isNotEmpty &&
        local_path.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      bool success = await _postDish();

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pop(context);
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Succès',
          text: 'Votre Plat est publié avec succès',
          textTextStyle: const TextStyle(
            fontFamily: 'Yaldevi',
          ),
          backgroundColor: Colors.white,
          confirmBtnColor: const Color(0xFFFFB261),
          confirmBtnText: 'D\'accord',
          confirmBtnTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Yaldevi',
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs .'),
        ),
      );
    }

  }
}