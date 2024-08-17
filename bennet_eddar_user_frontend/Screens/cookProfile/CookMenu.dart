import 'dart:async';
import 'package:bennet_eddar_app/commons/colors.dart';
import 'package:bennet_eddar_app/commons/styles.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final VoidCallback onPressed;
  final List<String> imagePaths;
  final double height;
  final String pubTime;

  final String name;
  final String rate;
  final String ratings;
  final String availability;

  Menu({
    required this.onPressed,
    required this.imagePaths,
    required this.height,
    required this.pubTime,
    required this.name,
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
        width: 600,
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: 10),
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
                        width: 700,
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
                  top: 10,
                  left: 4,
                  right: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.pubTime,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 13,
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
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20,),
                Text(
                  widget.name,
                  style: AppFonts.dishNameTextstyle,
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20,),
                Container(
                  child: Row(
                    children: [
                      Text(
                        widget.rate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 19,
                          color: Colors.grey,
                          fontFamily: 'Yaldevi',
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.star,
                        color: Color(0xFFF8B64C),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  widget.ratings,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    color: Colors.grey,
                    fontFamily: 'Yaldevi',
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
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
            SizedBox(height: 25),
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
      margin: EdgeInsets.all(4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? AppColors.accentColor : Colors.grey,
      ),
    );
  }
}
