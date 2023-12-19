import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/requests/request_form.dart';

class FloatingAddRequestBtn extends StatelessWidget {
  const FloatingAddRequestBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 10,
      backgroundColor: AppTheme.defaultBlue,
      isExtended: true,
      label: const Text(
        'Add request',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppTheme.defaultYellow,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(
              content: Text("Let's add new request!")));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RequestFormPage()),
        );
      },
      icon: const Icon(
        Icons.add_box_rounded,
        color: AppTheme.defaultYellow,
        size: 30.0,
      ),
    );
  }
}