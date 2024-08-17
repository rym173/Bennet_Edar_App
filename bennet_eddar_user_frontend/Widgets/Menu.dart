import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/commons/styles.dart';

class Menu extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath;
  final double height;
  final String cookName;
  final String pubTime;
  final String cookProfile;
  final String name;
  final String country;
  final String type;
  final String rate;
  final String ratings;
  final String availability;

  Menu({
    required this.onPressed,
    required this.imagePath,
    required this.height,
    required this.cookName,
    required this.pubTime,
    required this.cookProfile,
    required this.name,
    required this.country,
    required this.type,
    required this.rate,
    required this.ratings,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Stack(
                    children: [
                      Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                        height: height / 2,
                      ),
                      Positioned(
                        top: 20,
                        left: 4,
                        right: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                cookProfile,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cookName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontFamily: 'Yaldevi',
                                          shadows: [
                                            Shadow(
                                              color: Colors.white,
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
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontFamily: 'Yaldevi',
                                          shadows: [
                                            Shadow(
                                              color: Colors.white,
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
                ),
                height: height / 2,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Text(
                name,
                style: AppFonts.dishNameTextstyle,
              ),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                country,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                  color: Colors.grey,
                  fontFamily: 'Yaldevi',
                ),
              ),
              SizedBox(width: 7),
              Icon(
                Icons.fiber_manual_record,
                color: Colors.grey,
                size: 10,
              ),
              Text(
                type,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                  color: Colors.grey,
                  fontFamily: 'Yaldevi',
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Text(
                rate,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                  color: Colors.grey,
                  fontFamily: 'Yaldevi',
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.star,
                color: Color(0xFFF8B64C),
              ),
              Text(
                ratings,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                  color: Colors.grey,
                  fontFamily: 'Yaldevi',
                ),
              ),
              SizedBox(width: 50),
              Icon(
                Icons.watch_later,
                color: Colors.grey,
              ),
              Text(
                availability,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
