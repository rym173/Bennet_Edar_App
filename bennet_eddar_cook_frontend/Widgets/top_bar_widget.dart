import 'package:flutter/material.dart';
import '../commons/styles.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const AppTopBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: AppFonts.titleAppBarTextStyle,
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
