import 'package:bennet_eddar_cook/commons/colors.dart';
import 'package:bennet_eddar_cook/constants/endpoints.dart';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import 'package:bennet_eddar_cook/widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import '../../widgets/top_bar_widget.dart';
import '../../widgets/title_subtitle_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CookDetailsUtility {
  static Future<Map<String, dynamic>> fetchCookDetails(String cookId) async {
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
}

class changeLocation extends StatefulWidget {
  const changeLocation({Key? key}) : super(key: key);

  @override
  _changeLocationState createState() => _changeLocationState();
}

class _changeLocationState extends State<changeLocation> {
  Color searchIconColor = const Color(0xFF6C6C6C);
  final TextEditingController _textEditingController = TextEditingController();
  String userInput = '';
  List<String> suggestions = [];
  final String flaskEndpoint =
      'https://flask-cook-endpoint.vercel.app/enterLocation';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const AppTopBar(title: 'Trouvez des clients locaux'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.025),
            const AppSubtitle(
                text:
                    'Veuillez indiquer votre emplacement afin de trouver des clients à proximité de vous.'),
            SizedBox(height: screenHeight * 0.035),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: searchIconColor),
                suffixIcon: _textEditingController.text.isNotEmpty
                    ? Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _textEditingController.clear();
                            });
                          },
                          splashColor: Colors.grey.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.02),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : null,
                hintText: 'Entrer Votre Emplacement...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.02),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFFFB261)),
                  borderRadius: BorderRadius.circular(screenHeight * 0.02),
                ),
              ),
              onTap: () {
                setState(() {
                  searchIconColor = const Color(0xFFFFB261);
                });
              },
              onChanged: (value) async {
                setState(() {
                  userInput = value;
                });
                updateSuggestions();
              },
              onSubmitted: (value) {
                // Show bottom sheet when a suggestion is tapped
                if (suggestions.contains(value)) {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        LocationConfirmationPage(location: value),
                  );
                } else {

                }
              },
              style: const TextStyle(
                color: Color(0xFF010F07),
                fontFamily: 'Yaldevi',
              ),
            ),
            SizedBox(height: screenHeight * 0.016),
            Expanded(
              child: ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (suggestions.isNotEmpty) {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) =>
                              LocationConfirmationPage(
                                  location: suggestions[index]),
                        );
                      } else {
                     
                      }
                    },
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(
                        suggestions[index],
                        style: const TextStyle(
                          fontFamily: 'Yaldevi',
                          color: Color(0xFF010F07),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateSuggestions() async {
    final response =
        await http.get(Uri.parse('$flaskEndpoint?query=$userInput'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        suggestions = List<String>.from(jsonResponse['results']);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}

class LocationConfirmationPage extends StatefulWidget {
  final String location;

  LocationConfirmationPage({required this.location});

  @override
  _LocationConfirmationPageState createState() =>
      _LocationConfirmationPageState();
}

class _LocationConfirmationPageState extends State<LocationConfirmationPage> {
  bool confirmed = false;
  Map<String, dynamic> cookDetails = {}; // Initialize cook details here

  @override
  void initState() {
    super.initState();
    // Fetch cook details when the widget is initialized
    _fetchCookDetails();
  }

  Future<void> _fetchCookDetails() async {
    try {
      final cookId = (await getUserId()) ??
          'defaultUserId'; // Assuming you have a getUserId() function
      final Map<String, dynamic> details =
          await CookDetailsUtility.fetchCookDetails(cookId);
      setState(() {
        cookDetails = details;
      });
    } catch (error) {
      print('Error fetching cook details: $error');
      // Handle error
    }
  }

  Future<void> _updateLocation(String newLocation) async {
    final userId = await getUserId();

    final String updateEndpoint =
        'https://flask-cook-endpoint.vercel.app/updateLocation/$userId';

    try {
      final response = await http.post(
        Uri.parse(updateEndpoint),
        body: {'Location': newLocation},
      );

      if (response.statusCode == 200) {
        print('Location updated successfully');
        // Add any additional logic or UI updates after successful location update
      } else {
        print('Failed to update location. Status code: ${response.statusCode}');
        // Handle error
      }
    } catch (error) {
      print('Error: $error');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add an alert icon at the top
          Icon(
            Icons.warning,
            size: 40,
            color: AppColors.accentColor,
          ),
          SizedBox(height: 16),
          Text(
            'Votre emplacement actuel est:',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Yaldevi'),
          ),
          SizedBox(height: 10),
          Text(
            widget.location,
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 76, 89, 99),
                fontFamily: 'Yaldevi'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Return to TypeLocation
                },
                child: Text('Annuler',
                    style: TextStyle(color: AppColors.accentColor)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Call the Flask endpoint to update location
                  _updateLocation(widget.location);
                  setState(() {
                    confirmed = true;
                  });
                  Navigator.pop(context);
                  // Navigate to Edit Profile Settings or perform the corresponding action
                  if (confirmed) {
                    // Navigate to BottomBar page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomBar(
                          onSave: () {
                            // This function will be called when changes are saved in EditProfileScreen
                            setState(() {
                              _fetchCookDetails();
                            });
                          },
                        ),
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text('Confirmer',
                    style: TextStyle(color: AppColors.accentColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
