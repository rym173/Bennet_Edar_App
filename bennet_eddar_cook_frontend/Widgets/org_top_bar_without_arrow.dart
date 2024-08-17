import 'package:flutter/material.dart';
import '../commons/styles.dart';

class OrgAppTopBarNoArrw extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const OrgAppTopBarNoArrw({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: AppFonts.orgTitleAppBarTextStyle.copyWith(
          fontSize: screenWidth < 600 ? 20 : 24,
        ),
      ),
      centerTitle: true, // Center the title text
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
