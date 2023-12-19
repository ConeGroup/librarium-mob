import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';

class BookRequestHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Book Request',
              style: TextStyle(
                fontSize: 30,
                color: AppTheme.defaultBlue,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "Feel bored already? \n It's time to tell us what book(s) do you want to be added in Librarium!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.defaultBlue,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 20), // Add space between text and list items
        ],
      ),
    );
  }
}
