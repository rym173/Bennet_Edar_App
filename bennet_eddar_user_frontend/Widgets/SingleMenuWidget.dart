import 'package:flutter/material.dart';

class SingleMenuWidget extends StatelessWidget {
  final String imagePath;
  final String cookName;
  final String pubTime;
  final String cookProfile;
  final String name;
  final String type;
  final String price;
  final String availability;
  final String description;

  SingleMenuWidget({
    required this.imagePath,
    required this.cookName,
    required this.pubTime,
    required this.cookProfile,
    required this.name,
    required this.type,
    required this.price,
    required this.availability,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'Yaldevi',
                      ),
                    ),
                    Spacer(),
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xFFFFB261),
                        fontFamily: 'Yaldevi',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later,
                      color: Colors.grey,
                    ),
                    Text(
                      'Valable jusqu\'à $availability',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 150),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add logic
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color(0xFFFFB261),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Color(0xFFFFB261)),
                          ),
                        ),
                        child: Text(
                          'Emporter',
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
