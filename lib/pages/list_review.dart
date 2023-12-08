import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:librarium_mob/models/review_model.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/models/book_model.dart';

class ReviewListPage extends StatefulWidget {
  const ReviewListPage({Key? key}) : super(key: key);

  @override
  _ReviewListPageState createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  late Future<List<Review>> _reviews;
  late Future<List<Book>> _books;

  @override
  void initState() {
    super.initState();
    _reviews = fetchReview();
    _books = fetchBookCatalog();
  }

  Future<Book?> fetchBookById(int bookId) async {
    try {
      var url = Uri.parse('http://localhost:8000/reviews/get-book-by-id-mob/$bookId/');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return Book.fromJson(data);
      } else {
        throw Exception('Failed to fetch book details');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<List<Review>> fetchReview() async {
    try {
      var url = Uri.parse('http://localhost:8000/reviews/get-review-json/');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        List<Review> listReview = [];

        for (var reviewJson in data) {
          if (reviewJson != null) {
            listReview.add(Review.fromJson(reviewJson));
          }
        }
        return listReview;
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

    Future<List<Book>> fetchBookCatalog() async {
    var url = Uri.parse('http://localhost:8000/reviews/get-book-json/');

    try {
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        List<Book> bookCatalog = data.map((json) => Book.fromJson(json)).toList();
        return bookCatalog;
      } else {
        throw Exception('Failed to fetch book catalog');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      drawer: const LeftDrawer(),
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
                "Tidak ada data item.",
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
                      "Tidak ada data item.",
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
    Key? key,
    required this.book,
    required this.review,
  }) : super(key: key);

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
                    "${book.fields.title}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
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
                    "${review.fields.bookReviewDesc}",
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
              borderRadius: BorderRadius.only(
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
