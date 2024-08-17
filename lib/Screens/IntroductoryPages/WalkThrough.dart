import 'package:bennet_eddar_app/screens/sign_in/signIn.dart';
import 'package:bennet_eddar_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalkThrough extends StatefulWidget {
  WalkThrough({Key? key}) : super(key: key);

  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  int currentPage = 0;

  var descriptions = [
    "Tous vos favoris",
    "Offres de livraison gratuite",
    "Choisissez votre nourriture",
  ];

  var descriptions2 = [
    "Commandez auprès des meilleurs cuisiniers locaux.",
    "Livraison gratuite pour les nouveaux clients",
    "Trouvez facilement votre envie culinaire et découvrez les meilleurs plats préparés avec amour !",
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(3.0, 0.0),
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 40.0, bottom: 10.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        " Benet",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: screenWidth * 0.1,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "         Eddar",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: screenWidth * 0.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildPage(index, screenWidth, screenHeight);
              },
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  _buildSmallBox(i, i == currentPage),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: screenWidth * 0.9,
              child: currentPage == 2
                  ? AppElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                      label: "COMMENCER",
                    )
                  : SizedBox(), // Empty SizedBox when not in the last page
            ),
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.7),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index, double screenWidth, double screenHeight) {
    return Column(
      children: [
        SlideTransition(
          position: _slideAnimation,
          child: Image.asset(
            "assets/image/walkThrough/WalkThrough${index + 1}.png",
            width: screenWidth * 0.5,
            height: screenWidth * 0.5,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${descriptions[index]}',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                fontFamily: 'Yaldevi',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${descriptions2[index]}',
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
                fontFamily: 'Yaldevi',
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallBox(int selectedIndex, bool colored) {
    Color myColor = colored ? Color.fromARGB(255, 54, 143, 12) : Colors.grey;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.025,
      height: screenHeight * 0.0125,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: myColor,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
