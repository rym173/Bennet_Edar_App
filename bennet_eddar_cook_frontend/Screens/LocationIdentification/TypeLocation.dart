import 'package:bennet_eddar_cook/screens/LocationIdentification/LocationNotSupported.dart';
import 'package:bennet_eddar_cook/screens/SignUp/signUpphoneNumber.dart';
import 'package:flutter/material.dart';
import '../../widgets/top_bar_widget.dart';
import '../../widgets/title_subtitle_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TypeLocation extends StatefulWidget {
  const TypeLocation({Key? key}) : super(key: key);

  @override
  _TypeLocationState createState() => _TypeLocationState();
}

class _TypeLocationState extends State<TypeLocation> {
  Color searchIconColor = const Color(0xFF6C6C6C);
  final TextEditingController _textEditingController = TextEditingController();
  String userInput = '';
  List<String> suggestions = []; // Placeholder suggestions
  final String flaskEndpoint = 'https://flask-cook-endpoint.vercel.app/enterLocation';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const AppTopBar(title: 'Trouvez des cuisiniers locaux'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                height:
                    screenHeight * 0.025), // Adding some space between close icon and search bar
            const AppSubtitle(
                text:
                    'Veuillez indiquer votre emplacement afin de trouver des cuisiniers à proximité de vous..'),
            SizedBox(
                height: screenHeight * 0.035), // Adding some space between text and search bar
            // Search bar
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
                          splashColor: Colors.grey
                              .withOpacity(0.1), // Customize splash color
                          borderRadius: BorderRadius.circular(
                              screenHeight * 0.02), // Increase border radius for a more circular effect
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.grey, // Customize delete icon color
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
                  searchIconColor =
                      const Color(0xFFFFB261); // Change color when tapped
                });
              },
              onChanged: (value) async {
                setState(() {
                  userInput = value;
                });
                updateSuggestions();
              },
              onSubmitted: (value) {
                // Check if the user entered location is in suggestions
                if (suggestions.contains(value)) {
                  // Navigate to SignUpPhoneNumber page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SignUpScreenPhoneNumber(selectedLocation: value),
                    ),
                  );
                } else {
                  // Navigate to LocationNotSupported page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationNotSupported(),
                    ),
                  );
                }
              },
              style: const TextStyle(
                color: Color(0xFF010F07),
                fontFamily: 'Yaldevi',
              ),
            ),
            SizedBox(
                height:
                    screenHeight * 0.016), // Adding some space between search bar and suggestions
            // Display suggestions with localization sign
            Expanded(
              child: ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Check if the user selected a suggestion or not
                      if (suggestions.isNotEmpty) {
                        // Navigate to SignUpPhoneNumber page when a suggestion is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreenPhoneNumber(
                                selectedLocation: suggestions[index]),
                          ),
                        );
                      } else {
                        // Navigate to a page called LocationNotSupported if the search is empty
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationNotSupported(),
                          ),
                        );
                      }
                    },
                    child: ListTile(
                      leading: const Icon(Icons.location_on), // Localization sign
                      title: Text(
                        suggestions[index],
                        style: const TextStyle(
                          fontFamily:
                              'Yaldevi', // Specify your font family here
                          color: Color(0xFF010F07),
                        ),
                      ),
                      // Additional onTap logic if needed
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
    // Send a request to the Flask backend
    final response =
        await http.get(Uri.parse('$flaskEndpoint?query=$userInput'));

    if (response.statusCode == 200) {
      // Parse the response and update suggestions
      final jsonResponse = json.decode(response.body);
      setState(() {
        suggestions = List<String>.from(jsonResponse['results']);
      });
    } else {
      // Handle error if needed
      print('Error: ${response.statusCode}');
    }
  }
}
