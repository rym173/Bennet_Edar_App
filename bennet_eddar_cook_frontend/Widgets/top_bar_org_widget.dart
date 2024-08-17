import 'package:flutter/material.dart';
import '../commons/styles.dart';

class OrgAppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const OrgAppTopBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: AppFonts.orgTitleAppBarTextStyle.copyWith(
          fontSize: screenWidth < 600 ? 20 : 24,
        ),
      ),
      centerTitle: true, // Center the title text
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: screenHeight < 600 ? 24 : 28,
        ),
        onPressed: () {
          Navigator.pop(context); // Navigate back when the back button is pressed
        },
      ),
    );
  }
}


