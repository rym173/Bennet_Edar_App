import 'package:bennet_eddar_app/widgets/top_bar_org_widget.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/screens/Home&Details/MostPopMenus.dart';
import 'package:bennet_eddar_app/data/menu_data.dart';
import 'package:bennet_eddar_app/screens/Home&Details/SingleMenuWidget.dart';

class SingleMenu extends StatefulWidget {
  final String id;

  SingleMenu({Key? key, required this.id}) : super(key: key);

  @override
  _SingleMenuState createState() => _SingleMenuState();
}

class _SingleMenuState extends State<SingleMenu> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final menuItem = menuData[widget.id];

    if (menuItem == null) {
      return const Scaffold(
        body: Center(
          child: Text('Menu non trouvé!'),
        ),
      );
    }

    return Scaffold(
      appBar: OrgAppTopBar(title: 'MENU ${widget.id}'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              child: SingleMenuWidget(
                cookName: menuItem['cookName'] ?? '',
                pubTime: menuItem['pubTime'] ?? '',
                cookProfile: menuItem['cookProfile'] ?? '',
                price: menuItem['price'] ?? '',
                availability: menuItem['availability'] ?? '',
                menuId: widget.id,
                width: screenWidth,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Les Plus Populaires',
                  style: TextStyle(
                    color: Color(0xFF010F07),
                    fontSize: 20,
                    fontFamily: 'Yaldevi',
                    fontWeight: FontWeight.w300,
                    height: 0,
                    letterSpacing: 0.44,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  menuData.keys.where((key) => key != widget.id).map((key) {
                final menuItem = menuData[key];
                if (menuItem == null) {
                  return SizedBox.shrink();
                }

                return Column(
                  children: [
                    MostPopMenus(
                      title: menuItem['name'] ?? '',
                      description: '${menuItem['description'] ?? ''}',
                      imagePath: menuItem['imagePath'] ?? 'default_image_path',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SingleMenu(id: (key).toString()),
                          ),
                        );
                      },
                      price: menuItem['price'] ?? '',
                      height: screenHeight,
                      width : screenWidth,
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
