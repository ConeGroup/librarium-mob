import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // colors used for the app theme

  // contoh
  static const Color defaultBlue = Color.fromRGBO(24, 58, 90, 1);
  static const Color defaultYellow = Color.fromRGBO(255, 219, 35, 1);
  static const Color darkBeige = Color(0xFFD8C3A5);
}

AppBar appBar = AppBar(
        title: const Text('Librarium',
        style: TextStyle(
                    fontSize: 35,
                    color: AppTheme.defaultYellow,
                    fontWeight: FontWeight.bold,
                  ),
              ),
        backgroundColor: AppTheme.defaultBlue,
        toolbarHeight: 60.0,
  );
