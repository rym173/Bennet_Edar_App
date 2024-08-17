
import 'package:flutter/material.dart';
import '../../commons/styles.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  AppTopBar({required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppFonts.titleAppBarTextStyle,
      ),
    );
  }
}
