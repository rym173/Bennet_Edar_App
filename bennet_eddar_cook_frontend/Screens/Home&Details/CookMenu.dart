import 'dart:async';
import 'package:bennet_eddar_cook/commons/colors.dart';
import 'package:bennet_eddar_cook/utils/Posts.dart';
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
  final int menuId;

  const Menu({
    Key? key,
    required this.onPressed,
    required this.imagePaths,
    required this.height,
    required this.pubTime,
    required this.name,
    required this.rate,
    required this.ratings,
    required this.availability,
    required this.menuId,
  }) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;
    void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer la publication'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette publication ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color:  AppColors.accentColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color:  AppColors.accentColor)),
              onPressed: () {
                print(this.widget.menuId);
                _deletePost(this.widget.menuId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < widget.imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: 600,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 209, 209, 209).withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white, // Background color of the container
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Stack(
  children: <Widget>[
   
  ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: widget.height / 2,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imagePaths.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.imagePaths[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
    Positioned(
      right: -1.5,
      top: -2,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 20,
        child: PopupMenuButton<String>(
          icon: Icon(Icons.delete, color: Colors.black),
          onSelected: (value) {
            if (value == 'delete') {
              _showDeleteDialog();
            }
          },
          
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'delete',

              child: Text('Supprimer la publication'),
            ),
            // ... autres options ...
          ],
          shadowColor: Colors.orange,
        ),
      ),
    ),
  ],
),
              
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Publié le: ${widget.pubTime}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.rate,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                  Text(
                    'Ratings: ${widget.ratings}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.watch_later,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.availability,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.orange : Colors.grey,
      ),
    );
  }
void _deletePost(int postId) async {
  print('Deleting post with ID: $postId'); 
  try {
    await Posts.deletePost(postId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post supprimé avec succès'),
      ),
    );

    // Naviguer vers la page d'accueil et supprimer toutes les autres pages de la pile de navigation
    Navigator.of(context).pushNamedAndRemoveUntil('/bottomBar', (Route<dynamic> route) => false);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de la suppression du post : $e'),
      ),
    );
  }
}
}
