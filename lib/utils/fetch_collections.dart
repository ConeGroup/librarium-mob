import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/models/collections_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

    // Fetch ini digunakan untuk mengambil data buku berdasarkan id DONE
    Future<Book> fetchUserbyId(int userId) async {
        var url = Uri.parse('http://127.0.0.1:8000/collection/get-book-by-id-json-mob/$userId/');
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

    // Fetch ini digunakan untuk mengambil semua buku yang ada DONE
    Future<List<Book>> fetchBookCatalog() async {
    var url = Uri.parse('http://127.0.0.1:8000/collection/get-book-json/');
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
  // mengambil buku berdasarkan ID
    Future<Book> fetchBookById(int bookId) async {
      var url = Uri.parse('http://localhost:8000/collection/get-book-by-id-json-mob/$bookId/');
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



  // mengambil semua collections dari user
  Future<List<CollectionItemModel>> fetchCollection(CookieRequest request) async {
      try {
        var response = await request.get('http://127.0.0.1:8000/collection/get-collections-by-user-mob/');

          List<CollectionItemModel> listCollection = [];

          for (var reviewJson in response) {
            if (reviewJson != null) {
              listCollection.add(CollectionItemModel.fromJson(reviewJson));
            }
          }
          return listCollection;
      } catch (error) {
        print('Error during fetchItem: $error');
        throw Exception('ErrorReview: $error');
      }
    }

  //Mengambil collection yang terdapat buku berdasarkan id buku
  Future<List<CollectionItemModel>> fetchCollectionBook(CookieRequest request, int bookId) async {
    var response;
      try {
        response = await request.get('http://127.0.0.1:8000/collection/get-collections-by-book-json-mob/$bookId/');

          List<CollectionItemModel> listCollection = [];

          for (var reviewJson in response) {
            if (reviewJson != null) {
              listCollection.add(CollectionItemModel.fromJson(reviewJson));
            }
          }
          return listCollection;
      } catch (error) {
        return [];
      }
    }
    //Mengambil semua buku yang ada di collections
    Future<List<CollectionItemModel>> fetchBookCollection(CookieRequest request, int collectionId) async {
      var response;
        try {
          response = await request.get('http://127.0.0.1:8000/collection/get-book-by-collection-json-mob/$collectionId/');

            List<CollectionItemModel> listCollection = [];

            for (var reviewJson in response) {
              if (reviewJson != null) {
                listCollection.add(CollectionItemModel.fromJson(reviewJson));
              }
            }
            return listCollection;
        } catch (error) { 
          return [];
        }
      }

