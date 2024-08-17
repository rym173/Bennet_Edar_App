import 'package:flutter/material.dart';

class BlackAppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BlackAppTopBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Color(0xFF010F07),
          ),
          onPressed: () {},
        ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w200,
            fontFamily: 'Yaldevi',
            fontSize: screenWidth < 600 ? 20 : 24,
            color: const Color(0xFF010F07),
          ),
      ),
      centerTitle: true, // Center the title text
    );
  }
}
