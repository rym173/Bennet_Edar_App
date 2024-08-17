import 'package:bennet_eddar_app/data/menu_dataa.dart';
import 'package:bennet_eddar_app/screens/Home&Details/SingleMenu.dart';
import 'package:bennet_eddar_app/widgets/org_top_bar_without_arrow.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/commons/styles.dart';
import 'package:bennet_eddar_app/screens/Home&Details/Menu.dart';
import 'package:bennet_eddar_app/data/menu_data.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double containerHeight = 350;

  @override
  Widget build(BuildContext context) {
    
  double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: OrgAppTopBarNoArrw(
        title: 'ACCEUIL',
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 10, bottom: 10),
                  child: Text(
                    'Menus du Jour :',
                    style: AppFonts.titleAppBarTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: MenuDataa.menus.length,
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
                              color: const Color.fromARGB(154, 158, 158, 158)
                                  .withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Menu(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SingleMenu(id: (index + 1).toString()),
                              ),
                            );
                          },
                          imagePaths: (dishes.map(
                              (item) => item['imagePath'] as String)).toList(),
                          cookName: menu['cookName'] ?? '',
                          pubTime: menu['pubTime'] ?? '',
                          cookProfile: menu['cookProfile'] ?? '',
                          height: containerHeight,
                          name: menu['name'] ?? '',
                          country: menu['country'] ?? '',
                          type: menu['type'] ?? '',
                          rate: menu['rate'] ?? '',
                          ratings: menu['ratings'] ?? '',
                          availability: menu['availability'] ?? '',
                          width:screenWidth,
                        ),
                      ),
                      const Divider(
                        thickness: 0.7,
                        color: const Color.fromARGB(181, 158, 158, 158),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
