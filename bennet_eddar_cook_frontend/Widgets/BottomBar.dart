import 'package:bennet_eddar_cook/screens/AccountSettings/AccountSettings.dart';
import 'package:bennet_eddar_cook/screens/Home&Details/HomePage.dart';
import 'package:bennet_eddar_cook/screens/PostMenu/AddOptions.dart';
import 'package:bennet_eddar_cook/screens/PostMenu/PostDish.dart';
import 'package:bennet_eddar_cook/screens/PostMenu/PostMenu.dart';
import 'package:bennet_eddar_cook/screens/YourOrders/YourOrders.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final VoidCallback? onSave;
  const BottomBar({super.key,  this.onSave});

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const CookProfile(),
    const AddOptions(),
    const YourOrders(),
    const AccountSettings(),
    // Other pages...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFF8B64C),
        unselectedItemColor: const Color(0xFF6C6C6C),
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 1) {
            _showOptionsModal(context); // Appel de votre fonction
          } else {
            setState(() {
              _selectedIndex = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_rounded),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ajouter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_rounded),
            label: 'Your Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: const Text('PUBLIER UN MENU'),
                onTap: () {
                  Navigator.pop(context); // Close the modal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostMenu()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.restaurant_rounded),
                title: const Text('PUBLIER UN PLAT'),
                onTap: () {
                  Navigator.pop(context); // Close the modal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostDish()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
