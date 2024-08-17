
import 'package:flutter/material.dart';
import '../../commons/styles.dart';

class TopBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  TopBar2({required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppFonts.titleAppBarTextStyle2,
      ),
      leading: Icon(Icons.keyboard_arrow_left),
    );
  }
}
