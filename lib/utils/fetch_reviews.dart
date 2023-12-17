import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/models/review_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Review>> fetchReview(CookieRequest request) async {
    try {
      var response = await request.get('http://127.0.0.1:8000/reviews/get-rev-by-user-mob/');

        List<Review> listReview = [];

        for (var reviewJson in response) {
          if (reviewJson != null) {
            listReview.add(Review.fromJson(reviewJson));
          }
        }
        return listReview;
      // } 
      // else {
      //   throw Exception('Failed to load reviews');
      // }
    } catch (error) {
      print('Error during fetchItem: $error');
      throw Exception('ErrorReview: $error');
    }
  }

    Future<List<Book>> fetchBookCatalog() async {
    var url = Uri.parse('http://127.0.0.1:8000/reviews/get-book-json/');
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


  Future<Book> fetchBookById(int bookId) async {
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
  }

// mengambil semua review yang ada
  Future<List<Review>> fetchAllReview(CookieRequest request) async {
    try {
      var response = await request.get('http://127.0.0.1:8000/reviews/get-review-json/');
        List<Review> listReview = [];

        for (var reviewJson in response) {
          if (reviewJson != null) {
            listReview.add(Review.fromJson(reviewJson));
          }
        }
        return listReview;
    } catch (error) {
      throw Exception('ErrorReview: $error');
    }
  }

   Future<Book> fetchUserbyId(int userId) async {
      var url = Uri.parse('http://127.0.0.1:8000/reviews/get-book-by-id-mob/$userId/');
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
  }


Future<List<Review>> fetchBookReview(CookieRequest request, int bookId) async {
  var response;
    try {
      response = await request.get('http://127.0.0.1:8000/reviews/get-rev-by-book-mob/$bookId/');

        List<Review> listReview = [];

        for (var reviewJson in response) {
          if (reviewJson != null) {
            listReview.add(Review.fromJson(reviewJson));
          }
        }
        return listReview;
    } catch (error) {
      return [];
    }
  }