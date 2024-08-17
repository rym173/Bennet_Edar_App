import 'package:bennet_eddar_cook/screens/PostMenu/PostDish.dart';
import 'package:bennet_eddar_cook/screens/PostMenu/PostMenu.dart';
import 'package:bennet_eddar_cook/widgets/org_top_bar_without_arrow.dart';
import 'package:flutter/material.dart';

class AddOptions extends StatelessWidget {
  const AddOptions({super.key});
  
  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.menu_book_outlined),
                title: Text('PUBLIER UN MENU'),
                onTap: () {
                  Navigator.pop(context); // Close the modal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostMenu()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.restaurant_rounded),
                title: Text('PUBLIER UN PLAT'),
                onTap: () {
                  Navigator.pop(context); // Close the modal
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostDish()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrgAppTopBarNoArrw(
        title: "PUBLIER UN MENU/PLAT",
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showOptionsModal(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFB261),
                  padding: EdgeInsets.all(20),
                ),
                child: Column(
                  children: [
                    Icon(Icons.add, size: 50, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'AJOUTER',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
