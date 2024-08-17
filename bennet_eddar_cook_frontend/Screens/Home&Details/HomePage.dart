import 'package:bennet_eddar_cook/commons/colors.dart';
import 'package:bennet_eddar_cook/commons/images.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:bennet_eddar_cook/widgets/org_top_bar_without_arrow.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bennet_eddar_cook/screens/Home&Details/CookProfileWidget.dart';
import 'package:bennet_eddar_cook/utils/Posts.dart';
import 'package:bennet_eddar_cook/screens/Home&Details/CookMenu.dart';
import 'package:bennet_eddar_cook/screens/gallery/CookGallery.dart';

class CookProfile extends StatefulWidget {
  const CookProfile({super.key});

  @override
  _CookProfileState createState() => _CookProfileState();
}

class _CookProfileState extends State<CookProfile> {
  double containerHeight = 400;
  String cookFullName = '';

  void loadUserName() async {
    cookFullName = await getUserName();
    setState(() {});
  }

  Future<void> _refresh() async {
    // Fetch new menus with dishes
    await Posts.getMenusAndDishesForCurrentCook();
    // Call setState to trigger a rebuild of the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrgAppTopBarNoArrw(
        title: cookFullName,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
             CookProfileWidget(),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 0.7,
                color: Color.fromARGB(181, 158, 158, 158),
              ),
              const SizedBox(height: 20),
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Row(
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
                      const SizedBox(height: 10),
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
                                color: Colors.black
                                    .withOpacity(0.4959571659564972),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Galerie",
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
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 0.7,
                color: Color.fromARGB(181, 158, 158, 158),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Row(
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
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: FutureBuilder(
                      future: Posts.getMenusAndDishesForCurrentCook(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'La liste de vos plats du jour est vide, ',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontFamily: 'Yaldevi',
                                  ),
                                ),
                                TextSpan(
                                  text: '\n \n Poster un menu par ici',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.accentColor,
                                    fontFamily: 'Yaldevi',
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Naviguer vers la page de publication de menu
                                      Navigator.of(context)
                                          .pushNamed('/postMenu');
                                    },
                                ),
                              ],
                            ),
                          );
                        }

                        final List<dynamic> menus =
                            snapshot.data! as List<dynamic>;

                        return ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: menus.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> menu =
                                menus[index] as Map<String, dynamic>;

                            if (menu.containsKey('dishes') &&
                                menu['dishes'] is List) {
                              FirebaseStorage storage =
                                  FirebaseStorage.instance;

                              Future<List<String>> getImageUrls(
                                  List<String> imagePaths) async {
                                List<String> imageUrls = [];

                                for (String path in imagePaths) {
                                  final ref = storage.ref(path);
                                  final imageUrl = await ref.getDownloadURL();
                                  imageUrls.add(imageUrl);
                                }

                                return imageUrls;
                              }

                              List<dynamic> dishes =
                                  menu['dishes'] as List<dynamic>;

                              List<String> imagePaths = dishes
                                  .map((dish) {
                                    if (dish is Map<String, dynamic> &&
                                        dish.containsKey('Dish_Pic')) {
                                      return dish['Dish_Pic'];
                                    }
                                  })
                                  .where((dishPic) => dishPic != null)
                                  .toList()
                                  .cast<String>();

                              String name = menu['Menu_Name'] ?? '';

                              String rate = '';
                              String ratings = '';

                              DateTime now = DateTime.now();
                              DateTime start = DateTime.parse(
                                  dishes[0]['TimeAvailabilityStart']);
                              DateTime end = DateTime.parse(
                                  dishes[0]['TimeAvailabilityEnd']);

                              Duration difference;
                              if (now.isAfter(start) && now.isBefore(end)) {
                                difference = end.difference(now);
                              } else {
                                difference = end.difference(start);
                              }

                              String availability =
                                  '${difference.inHours} h ${difference.inMinutes % 60} min';
                              String pubTime = '';
                              if (menu['created_at'] != null) {
                                DateTime date =
                                    DateTime.parse(menu['created_at']);
                                pubTime = DateFormat('dd/MM/yyyy à HH:mm')
                                    .format(date);
                              }

                              return FutureBuilder<List<String>>(
                                future: Future.value(imagePaths),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<String>> snapshot) {
                                  if (snapshot.hasData) {
                                    List<String> imageUrls =
                                        snapshot.data ?? [];

                                    return Menu(
                                      onPressed: () {},
                                      imagePaths: imageUrls,
                                      height: 300,
                                      pubTime: pubTime,
                                      name: name,
                                      rate: rate,
                                      ratings: ratings,
                                      availability: availability,
                                      menuId: menu['Menu_ID'],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadUserName();
  }
}
