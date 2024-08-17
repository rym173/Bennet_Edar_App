import 'dart:async';
import 'package:bennet_eddar_app/commons/colors.dart';
import 'package:bennet_eddar_app/commons/styles.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final VoidCallback onPressed;
  final List<String> imagePaths;
  final double height;
  final double width;
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
    required this.imagePaths,
    required this.height,
    required this.width,
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
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    // Set up a timer to automatically change the page every 5 seconds (adjust as needed)
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < widget.imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: widget.width * 0.02), // Adjust as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: widget.height / 2,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imagePaths.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: widget.width,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.imagePaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: widget.width * 0.02, // Adjust as needed
                  left: widget.width * 0.005, // Adjust as needed
                  right: widget.width * 0.006, // Adjust as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: widget.width * 0.08, // Adjust as needed
                        height: widget.width * 0.08, // Adjust as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          widget.cookProfile,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: widget.width * 0.002), // Adjust as needed
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.cookName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: widget.width * 0.04, // Adjust as needed
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
                                  widget.pubTime,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: widget.width * 0.03, // Adjust as needed
                                    color: Colors.black,
                                    fontFamily: 'Yaldevi',
                                    fontWeight: FontWeight.bold,
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
            SizedBox(height: widget.width * 0.12), // Adjust as needed
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: widget.width * 0.05), // Adjust as needed
                Text(
                  widget.name,
                  style: AppFonts.dishNameTextstyle,
                ),
              ],
            ),
            SizedBox(height: widget.width * 0.12), // Adjust as needed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: widget.width * 0.05), // Adjust as needed
                Container(
                  child: Row(
                    children: [
                      Text(
                        widget.rate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: 'Yaldevi',
                        ),
                      ),
                      SizedBox(width: widget.width * 0.01), // Adjust as needed
                      Icon(
                        Icons.star,
                        color: Color(0xFFF8B64C),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: widget.width * 0.01), // Adjust as needed
                Text(
                  widget.ratings,
                  // ... (remaining code)
                ),
                SizedBox(width: widget.width * 0.05), // Adjust as needed
                Container(
                  margin: EdgeInsets.only(right: widget.width * 0.01), // Adjust as needed
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: Colors.grey,
                      ),
                      SizedBox(width: widget.width * 0.005), // Adjust as needed
                      Text(
                        '${widget.availability}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 19,
                          color: Colors.grey,
                          fontFamily: 'Yaldevi',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.width * 0.025), // Adjust as needed
            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imagePaths.length,
                (index) => buildDot(index: index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: EdgeInsets.all(widget.width * 0.005), // Adjust as needed
      width: widget.width * 0.02, // Adjust as needed
      height: widget.width * 0.02, // Adjust as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? AppColors.accentColor : Colors.grey,
      ),
    );
  }
}
