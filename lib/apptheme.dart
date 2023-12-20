import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/edit_profile.dart';

class AppTheme {
  AppTheme._();

  // colors used for the app theme

  // contoh
  static const Color defaultBlue = Color.fromRGBO(24, 58, 90, 1);
  static const Color defaultYellow = Color.fromRGBO(255, 219, 35, 1);
  static const Color darkBeige = Color(0xFFD8C3A5);
}

class AppBarBuild extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBuild({super.key});

  @override
  Widget build(BuildContext context) {
    // final request = context.watch<CookieRequest>();

    return AppBar(
      title: const Text(
        'Librarium',
        style: TextStyle(
          fontSize: 35,
          color: AppTheme.defaultYellow,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppTheme.defaultBlue,
      toolbarHeight: 80.0,
      centerTitle: true,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          iconSize: 36,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserPage()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
