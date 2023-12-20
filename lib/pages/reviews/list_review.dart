import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/models/review_model.dart';
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/utils/fetch_reviews.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewListPage extends StatefulWidget {
  const ReviewListPage({super.key});

  @override
  _ReviewListPageState createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {

  late Future<List<Review>> _reviews;
  late Future<List<Book>> _books;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    _reviews = fetchReview(request);
    _books = fetchBookCatalog();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Reviews',
        style: TextStyle(
            fontSize: 35,
            color: AppTheme.defaultYellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 80.0,
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Review>>(
        future: _reviews,
        builder: (context, AsyncSnapshot<List<Review>> reviewSnapshot) {
          if (reviewSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (reviewSnapshot.hasError) {
            return Center(child: Text('Error: ${reviewSnapshot.error}'));
          } else if (!reviewSnapshot.hasData || reviewSnapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "You haven't review any book yet",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return FutureBuilder<List<Book>>(
              future: _books,
              builder: (context, AsyncSnapshot<List<Book>> bookSnapshot) {
                if (bookSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (bookSnapshot.hasError) {
                  return Center(child: Text('Error: ${bookSnapshot.error}'));
                } else if (!bookSnapshot.hasData || bookSnapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "You haven't review any book yet",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: reviewSnapshot.data!.length,
                    itemBuilder: (context, index) {
                      var review = reviewSnapshot.data![index];
                      var book = bookSnapshot.data!.firstWhere(
                        (book) => book.pk == review.fields.bookId,
                        );
                      return ReviewListItem(
                        book: book,
                        review: review,
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
class ReviewListItem extends StatelessWidget {
  final Book book;
  final Review review;

  const ReviewListItem({
    super.key,
    required this.book,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side (book details)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.fields.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Text(
                        " ${review.fields.rating.toString()}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                        review.fields.bookReviewDesc,
                        style: const TextStyle(fontSize: 14),
                  ),
                    
                ],
              ),
            ),
          ),
          // Right side (book image)
          Container(
            width: 100,
            height: 150,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(book.fields.imageL),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
