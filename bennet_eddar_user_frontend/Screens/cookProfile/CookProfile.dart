import 'dart:ui';
import 'package:bennet_eddar_app/commons/images.dart';
import 'package:bennet_eddar_app/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/data/cookData.dart';
import 'package:bennet_eddar_app/screens/cookProfile/CookProfileWidget.dart';
import 'package:bennet_eddar_app/data/menu_data.dart';
import 'package:bennet_eddar_app/data/menu_dataa.dart';
import 'package:bennet_eddar_app/screens/cookProfile/CookMenu.dart';
import 'package:bennet_eddar_app/screens/cookProfile/CookGallery.dart'; 

class CookProfile extends StatefulWidget {
  CookProfile({Key? key}) : super(key: key);

  @override
  _CookProfileState createState() => _CookProfileState();
}

class _CookProfileState extends State<CookProfile> {
  double containerHeight = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrgAppTopBar(title: cookFullName),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            CookProfileWidget(
              cookName: cookFullName,
              rate: rates,
              location: location,
              cookProfilePicture: cookProfilePicture,
              bio: bio,
            ),
            SizedBox(height: 10,),
            Divider(
              thickness: 0.7,
              color: const Color.fromARGB(181, 158, 158, 158),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CookGalleryScreen(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Les spécialités du chef",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Yaldevi',
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 17,
                          weight: 400,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ClipRect(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              tlitli_image,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 465,
                            height: 204.5,
                            decoration: ShapeDecoration(
                              color: Colors.black.withOpacity(0.4959571659564972),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Gallerie",
                                style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, 0),
                                      blurRadius: 7,
                                    ),
                                  ],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Yaldevi',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              thickness: 0.7,
              color: const Color.fromARGB(181, 158, 158, 158),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  Plats Du jour",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Yaldevi',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      var dishes = MenuDataa.menus[(index + 1).toString()] ?? [];
                      var menu = menuData[(index + 1).toString()] ?? {};
                      return Column(
                        children: [
                          Container(
                            height: containerHeight,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                  color: const Color.fromARGB(154, 158, 158, 158).withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Menu(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CookProfile(),
                                  ),
                                );
                              },
                              imagePaths: (dishes.map(
                                (item) => item['imagePath'] as String)).toList(),
                              pubTime: menu['pubTime'] ?? '',
                              height: containerHeight,
                              name: menu['name'] ?? '',
                              rate: menu['rate'] ?? '',
                              ratings: menu['ratings'] ?? '',
                              availability: menu['availability'] ?? '',
                            ),
                          ),
                          Divider(
                            thickness: 0.7,
                            color: const Color.fromARGB(181, 158, 158, 158),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
