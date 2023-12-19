import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/models/collections_model.dart';
import 'package:librarium_mob/pages/collections/collection_add_book_form.dart';
import 'package:librarium_mob/pages/collections/collection_catalog_page.dart';
import 'package:librarium_mob/pages/collections/collections_form.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CollectionListPage extends StatefulWidget {
  const CollectionListPage({Key? key}) : super(key: key);

  @override
  State<CollectionListPage> createState() => _CollectionListPageState();
}

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

class _CollectionListPageState extends State<CollectionListPage> {
  late Future<List<CollectionItemModel>> _collectionUser = Future.value([]);
  late Future<List<Book>> _bookCatalog = Future.value([]);

  @override
  void initState() {
    super.initState();
    fetchData(); // Memanggil fungsi untuk mengambil data
  }

  Future<void> fetchData() async {
    final request = context.read<CookieRequest>();

    try {
      // Mengambil data koleksi dan katalog buku
      final collectionData = await fetchCollection(request);
      final bookData = await fetchBookCatalog();

      setState(() {
        _collectionUser = Future.value(collectionData);
        _bookCatalog = Future.value(bookData);
      });
    } catch (error) {
      // Menangani kesalahan jika ada
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Your Collections")),
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<CollectionItemModel>>(
        future: _collectionUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No Collection available.",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            );
          } else {
            return FutureBuilder<List<Book>>(
              future: _bookCatalog,
              builder: (context, bookSnapshot) {
                if (bookSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (bookSnapshot.hasError) {
                  return Center(child: Text('Error: ${bookSnapshot.error}'));
                } else if (!bookSnapshot.hasData || bookSnapshot.data!.isEmpty) {
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
                      var collection = snapshot.data![index];
                      var booksInCollection = bookSnapshot.data!
                          .where((book) => collection.fields.books.contains(book.pk))
                          .toList();

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  '${collection.fields.name}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Column(
                                children: booksInCollection.map((book) {
                                  return CollectionListItem(
                                    collection: collection,
                                    book: book,
                                    onDelete: () {
                                      // Implementasi fungsi onDelete jika diperlukan
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle navigasi ke halaman penambahan buku ke dalam koleksi
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => 
                                        AddBooksToCollectionPage(
                                          collection: collection,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppTheme.defaultBlue,
                                    onPrimary: Colors.yellow,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('Add Books'),
                                ),
                              ),
                            ],  
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            heroTag: "leftButton", // Memberikan tag yang unik
            onPressed: () {
              // Logika untuk tombol kiri
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CollectionCatalogPage(),
                ),
              );
            },
            child: const Icon(Icons.list, color: Colors.yellow), // Ganti dengan ikon yang sesuai
            backgroundColor:AppTheme.defaultBlue, // Ganti dengan warna yang sesuai
          ),
          FloatingActionButton(
            heroTag: "rightButton", // Memberikan tag yang unik
            onPressed: () {
              // Logika untuk tombol kanan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CollectionFormPage(),
                ),
              );
            },
            child: const Icon(Icons.add, color: Colors.yellow), // Ganti dengan ikon yang sesuai
            backgroundColor: AppTheme.defaultBlue, // Ganti dengan warna yang sesuai
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      drawer: const LeftDrawer(),
    );
  }
}

class CollectionListItem extends StatelessWidget {
  final CollectionItemModel collection;
  final Book book;
  final Function onDelete;

  const CollectionListItem({
    Key? key,
    required this.collection,
    required this.book,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.defaultBlue,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Handle on tap action here
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tambahkan bagian untuk menampilkan gambar buku
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.fields.imageL, // Ganti dengan properti yang menyimpan URL gambar buku
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${book.fields.title}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Author: ${book.fields.author}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle delete action here
                  onDelete();
                },
                icon: const Icon(Icons.delete),
                color: Colors.red, // Change the color as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}


