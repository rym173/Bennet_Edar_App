import 'package:bennet_eddar_app/commons/colors.dart';
import 'package:bennet_eddar_app/commons/images.dart';
import 'package:flutter/material.dart';

class CookProfileWidget extends StatefulWidget {
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
  _CookProfileWidgetState createState() => _CookProfileWidgetState();
}

class _CookProfileWidgetState extends State<CookProfileWidget> {
  bool notificationsEnabled = false;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
      
                    children: [
                      Text(
                        widget.cookName,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 17, 17, 17),
                          fontSize: 23,
                          fontFamily: 'Yaldevi',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.rate,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
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
                  SizedBox(width: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 14,
                      ),
                      Text(
                        widget.location,
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
                        widget.bio,
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
              SizedBox(
                height: 10,
                width: 23,
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(cook_profile_image),
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
                  setState(() {
                    notificationsEnabled = !notificationsEnabled;
                  });
                  // Implement logic based on notificationsEnabled
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 241, 241, 241),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(140, 40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      notificationsEnabled
                          ? Icons.notifications_off
                          : Icons.notifications,
                      color: Color(0xFFF8B64C),
                      size: 19,
                    ),
                    SizedBox(width: 6),
                    Text(
                      notificationsEnabled
                          ? 'Désactiver les notifications'
                          : 'Activer les notifications',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Yaldevi',
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to show the rating modal
                  _showRatingModal(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 241, 241, 241),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(100, 40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: AppColors.accentColor, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'Évaluer',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Yaldevi',
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
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

  void _showRatingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 25),
              Text(
                'Évaluer le cuisinier',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => IconButton(
                    icon: Icon(
                      index < 3 ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 36,
                    ),
                    onPressed: () {
                      // Implement logic to handle the rating
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
