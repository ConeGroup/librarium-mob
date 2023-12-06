import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/pages/review_form.dart';

class BookCatalogPage extends StatefulWidget {
  const BookCatalogPage({Key? key}) : super(key: key);

  @override
  _BookCatalogPageState createState() => _BookCatalogPageState();
}

class _BookCatalogPageState extends State<BookCatalogPage> {
  late Future<List<Book>> _bookCatalog;

  @override
  void initState() {
    super.initState();
    _bookCatalog = fetchBookCatalog();
  }

  Future<List<Book>> fetchBookCatalog() async {
    var url = Uri.parse('http://localhost:8000/reviews/get-book-json/');

    try {
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data =
            jsonDecode(utf8.decode(response.bodyBytes));
        List<Book> bookCatalog =
            data.map((json) => Book.fromJson(json)).toList();
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
        title: const Text('Book Catalog'),
      ),
      body: FutureBuilder<List<Book>>(
        future: _bookCatalog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No books available.",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var book = snapshot.data![index];
                return ListTile(
                  title: Text(book.fields.title),
                  subtitle: Text(book.fields.author),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewFormPage(book: book),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: BookCatalogPage(),
  ));
}
