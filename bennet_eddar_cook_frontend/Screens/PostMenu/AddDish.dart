import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bennet_eddar_cook/widgets/button_widget.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_org_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'CustomDateTimeRangePicker.dart';
import '../../models/Dish.dart';
import '../../utils/imagepicker.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';

class AddDish extends StatefulWidget {
  AddDish();

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late DateTime _startDate;
  late DateTime _endDate;
  late String local_path='';
  late int cookID;
  
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
      appBar: OrgAppTopBar(
        title: 'AJOUTER UN PLAT',
      ),
        body: SingleChildScrollView(
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
                    color: Color(0xB7D9D9D9),
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
                              width: double.infinity,
                              height: double.infinity,
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
                  _startDate = start;
                  _endDate = end;
                  if(_startDate.isAfter(_endDate)){
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
              AppElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                    _startDate != null &&
                    _endDate != null &&
                    _priceController.text.isNotEmpty &&
                    local_path.isNotEmpty) {
                      Dish dish =Dish(
                            cookID: cookID,
                            name:_nameController.text,
                            description: _descriptionController.text,
                            startDate: _startDate,
                            endDate: _endDate,
                            price: double.parse(_priceController.text),
                            picture_Path: local_path,
                          );
                      setState(() {
                        Navigator.pop(
                          context,
                          dish,
                        );
                      });
                    }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez remplir tous les champs.'),
                      ),
                    );
                  }
                },
                label: 'AJOUTER',
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future <void> CookID () async{
    String? userID = await getUserId();
    if (userID != null){
      cookID = int.parse(userID);
    }else {
      print('error getting user id');
    }
  }
}
