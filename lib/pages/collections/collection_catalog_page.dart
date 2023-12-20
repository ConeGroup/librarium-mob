import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librarium_mob/apptheme.dart';
import 'dart:convert';
import 'package:librarium_mob/models/loans_catalog_models.dart';

class CollectionCatalogPage extends StatefulWidget {
  const CollectionCatalogPage({Key? key}) : super(key: key);

  @override
  _CollectionCatalogPageState createState() => _CollectionCatalogPageState();
}

class _CollectionCatalogPageState extends State<CollectionCatalogPage> {
  late Future<List<LoansCatalog>> _LoansBookCatalog;

  @override
  void initState() {
    super.initState();
    _LoansBookCatalog = fetchBookCatalog();
  }

  Future<List<LoansCatalog>> fetchBookCatalog() async {
    var url = Uri.parse('https://fazle-ilahi-c01librarium.stndar.dev/show_loans/get_book_json/');

    try {
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data =
            jsonDecode(utf8.decode(response.bodyBytes));
        List<LoansCatalog> LoansBookCatalog =
            data.map((json) => LoansCatalog.fromJson(json)).toList();
        return LoansBookCatalog;
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
        title: const Center(
          child: Text(
            'Available Books',
          ),
        ),
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<LoansCatalog>>(
        future: _LoansBookCatalog,
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
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 13.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 2/3,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var book = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppTheme.defaultBlue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4.0,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              book.fields.imageL,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.fields.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.defaultYellow,
                                  ),
                                ),
                                Text(
                                  book.fields.author,
                                  style: TextStyle(fontSize: 12.0, color: AppTheme.darkBeige),
                                ),
                                Text(
                                  book.fields.year.toString(),
                                  style: TextStyle(fontSize: 12.0, color: AppTheme.darkBeige),
                                ),
                                Center(
                                  child: Text(
                                  book.pk.toString(),
                                  style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
    home: CollectionCatalogPage(),
  ));
}

