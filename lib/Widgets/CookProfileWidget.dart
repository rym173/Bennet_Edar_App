import 'package:flutter/material.dart';
import 'package:bennet_eddar_app/commons/styles.dart';

class CookProfileWidget extends StatelessWidget {
  final String cookName;
  final String rate;
  final String location;
  final String cookProfilePicture;
  final String bio;

  CookProfileWidget({
    required this.cookName,
    required this.rate,
    required this.location,
    required this.cookProfilePicture,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children:[
                      Text(
                        cookName,
                        style: AppFonts.NameTextStyle,
                      ),
                      SizedBox(width: 5),
                      Text(
                        rate,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xFFF8B64C),
                        size: 12,
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 14,
                      ),
                      Text(
                        location,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        bio,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color.fromARGB(226, 32, 32, 32),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 10,width: 12,),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(cookProfilePicture),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 215, 213, 213),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(140, 40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications, color: Color(0xFFF8B64C), size: 14),
                    SizedBox(width: 6),
                    Text(
                      'Autoriser les notifications',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Yaldevi',
                        fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 215, 213, 213),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(100, 40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'Évaluer',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Yaldevi',
                        fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
