import 'package:bennet_eddar_app/screens/search/searchResultPage.dart';
import 'package:flutter/material.dart';

class SearchForFood extends StatefulWidget {
  const SearchForFood({super.key});

  @override
  _SearchForFoodState createState() => _SearchForFoodState();
}

class _SearchForFoodState extends State<SearchForFood> {
  Color searchIconColor = const Color(0xFF6C6C6C);
  final TextEditingController _textEditingController = TextEditingController();
  String userInput = '';

  // List of food suggestions
  final List<String> foodSuggestions = [
    'Couscous',
    'Pizza',
    'Burger',
    'Sushi',
    'Salad',
    // Add more suggestions as needed
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.08,
          screenHeight * 0.08,
          screenWidth * 0.08,
          0.0, // Adjust the top padding
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.005), // Adjusted height
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
                          splashColor:
                              Colors.grey.withOpacity(0.1), // Customize splash color
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
                hintText: 'Chercher...',
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
              onChanged: (value) {
                setState(() {
                  userInput = value;
                });
              },
              style: const TextStyle(
                color: Color(0xFF010F07),
                fontFamily: 'Yaldevi',
              ),
            ),
            // Suggestions list
            if (_textEditingController.text.isNotEmpty)
              Container(
                height: screenHeight * 0.4,
                child: ListView.builder(
                  itemCount: foodSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(foodSuggestions[index]),
                      onTap: () {
                        // Navigate to a new page when suggestion is tapped
                        if (foodSuggestions[index] == 'Couscous') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultPage(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
