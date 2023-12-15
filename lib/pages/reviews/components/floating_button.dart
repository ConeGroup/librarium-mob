import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/pages/reviews/review_catalog.dart';
import 'package:librarium_mob/pages/reviews/review_form.dart';

class FloatingAddReviewBtn extends StatelessWidget {
  const FloatingAddReviewBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        elevation: 10,
        backgroundColor: AppTheme.defaultBlue,
        isExtended: true,
        label: const Text(
                    'Add review',
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
                  content: Text("Let's add new review!")));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookCatalogPage()),
              );
         },
        icon: const Icon(
                    Icons.add_comment,
                    color: AppTheme.defaultYellow,
                    size: 30.0,
                  ),
        );
  }
}

class FloatingThisBookReviewBtn extends StatelessWidget {
  final Book thisBook;

  const FloatingThisBookReviewBtn({super.key, required this.thisBook}); 
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        elevation: 10,
        backgroundColor: AppTheme.defaultBlue,
        isExtended: true,
        label: const Text(
                    'Add Review',
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
                  content: Text("Let's add new review!")));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewFormPage(book: thisBook)),
              );
         },
        icon: const Icon(
                    Icons.add_comment,
                    color: AppTheme.defaultYellow,
                    size: 30.0,
                  ),
        );
  }
}