import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/reviews/list_review.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../../models/review_model.dart';
import '../../../models/book_model.dart';
import 'section_title.dart';

class RecentReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    final Future<List<Review>> reviews = fetchReview(request);
    final Future<List<Book>> books = fetchBookCatalog();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Your Recent Reviews",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewListPage()),
              );
            },
          ),
        ),
        FutureBuilder<List<Review>>(
          future: reviews,
          builder: (context, AsyncSnapshot<List<Review>> reviewSnapshot) {
            if (reviewSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (reviewSnapshot.hasError) {
              return Center(child: Text('Error: ${reviewSnapshot.error}'));
            } else if (!reviewSnapshot.hasData || reviewSnapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "You haven't reviewed any book yet",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
              );
            } else {
              return Column(
                children: [
                  ReviewList(reviews: reviewSnapshot.data!, books: books),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Review> reviews;
  final Future<List<Book>> books;

  const ReviewList({
    Key? key,
    required this.reviews,
    required this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: books,
      builder: (context, AsyncSnapshot<List<Book>> bookSnapshot) {
        if (bookSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (bookSnapshot.hasError) {
          return Center(child: Text('Error: ${bookSnapshot.error}'));
        } else if (!bookSnapshot.hasData || bookSnapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "You haven't reviewed any book yet",
              style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
            ),
          );
        } else {
          final lastThreeReviews = reviews.length > 3
              ? reviews.sublist(reviews.length - 3)
              : reviews;

          return Column(
            children: lastThreeReviews.map((review) {
              var book = bookSnapshot.data!.firstWhere(
                (book) => book.pk == review.fields.bookId,
              );
              return ReviewListItem(
                book: book,
                review: review,
              );
            }).toList(),
          );
        }
      },
    );
  }
}