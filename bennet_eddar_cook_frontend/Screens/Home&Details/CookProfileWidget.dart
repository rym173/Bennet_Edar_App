import 'package:bennet_eddar_cook/commons/images.dart';
import 'package:bennet_eddar_cook/constants/endpoints.dart';
import 'package:bennet_eddar_cook/screens/cook_profile/editProfile.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CookProfileWidget extends StatefulWidget {
  const CookProfileWidget({Key? key}) : super(key: key);

  @override
  _CookProfileWidgetState createState() => _CookProfileWidgetState();
}

class _CookProfileWidgetState extends State<CookProfileWidget> {
  late Future<Map<String, dynamic>> _cookDetails;
  late String cookId;

  void init() async {
    cookId = (await getUserId()) ?? 'defaultUserId';
    print('Cook ID: $cookId');
    _cookDetails = fetchCookDetails();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<Map<String, dynamic>> fetchCookDetails() async {
    final response =
        await http.get(Uri.parse(getApiEndpointForCookDetails(cookId)));
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load cook details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cookDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Extract the cook details from the snapshot
          final cookDetails = snapshot.data as Map<String, dynamic>;

          return InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          cookDetails['Cook_Name'],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 17, 17, 17),
                            fontSize: 23,
                            fontFamily: 'Yaldevi',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          cookDetails['Ratings'] ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Color(0xFFF8B64C),
                          size: 12,
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 14,
                        ),
                        Text(
                          cookDetails['Location'] ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          cookDetails['Bio'] ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Color.fromARGB(226, 32, 32, 32),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen( onSave: () {
                    // This function will be called when changes are saved in EditProfileScreen
                    setState(() {
                      // Reload cook details or perform any other actions
                      _cookDetails = fetchCookDetails();
                    });
                  },
                ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(140, 40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.create_outlined, color: Colors.black, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            ' Modifier le Profil',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Yaldevi',
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10), // Add some spacing between cook details and profile picture
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    // You may need to handle the case where 'cook_profile_image' is not available
                    image: DecorationImage(
                      image: AssetImage(cook_profile_image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
