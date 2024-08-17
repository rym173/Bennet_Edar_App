import 'package:bennet_eddar_app/screens/cookProfile/CookProfile.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/screens/ordering/addToOrder.dart';
import 'package:bennet_eddar_app/screens/Home&Details/swapping_image_with_text_single_menu.dart';
import '../../data/menu_dataa.dart';

class SingleMenuWidget extends StatelessWidget {
  final String cookName;
  final String pubTime;
  final String cookProfile;
  final String price;
  final String availability;
  final String menuId;
  final double width;

  SingleMenuWidget({
    required this.cookName,
    required this.pubTime,
    required this.cookProfile,
    required this.price,
    required this.availability,
    required this.menuId,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    String currentMenu = menuId;
    List<Map<String, dynamic>> menuItems = MenuDataa.menus[currentMenu] ?? [];
    return InkWell(
      onTap: () {
        // Navigate to cook-page when the entire card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CookProfile(), // Replace with the actual CookPage widget
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  // Navigate to cook-page when "Nom" is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CookProfile(), // Replace with the actual CookPage widget
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 280,
                  child: Container(
                    height: 250,
                    child: SwappingImageWithText(
                      data: menuItems
                          .map((item) => ImageTextModel(
                                imagePath: item['imagePath']!,
                                title: item['dishName']!,
                                description: item['description']!,
                                price: item['price']!,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 50,
                right: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigate to cook-page when the cook profile is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CookProfile(), // Replace with the actual CookPage widget
                          ),
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          cookProfile,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cookName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'Yaldevi',
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 11, 10, 10),
                                      offset: Offset(0, 0),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                pubTime,
                                style:const  TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 254, 254),
                                  fontFamily: 'Yaldevi',
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Color.fromARGB(255, 5, 5, 5),
                                      offset: Offset(0, 0),
                                      blurRadius: 5,
                                    ),
                                  ],
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
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.watch_later,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Valable jusqu\'à $availability',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        color: Colors.grey,
                        fontFamily: 'Yaldevi',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width * 0.25),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddToOrderScreen(menuId: menuId),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color(0xFFFFB261),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Color(0xFFFFB261)),
                          ),
                        ),
                        child: const Text(
                          'Commander',
                          style: TextStyle(
                            fontFamily: 'Yaldevi',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
