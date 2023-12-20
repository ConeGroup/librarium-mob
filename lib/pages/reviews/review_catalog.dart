import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/pages/reviews/review_form.dart';
import 'package:librarium_mob/utils/fetch_reviews.dart';

class BookCatalogPage extends StatefulWidget {
  const BookCatalogPage({super.key});

  @override
  _BookCatalogPageState createState() => _BookCatalogPageState();
}

class _BookCatalogPageState extends State<BookCatalogPage> {
  late Future<List<Book>> _bookCatalog;

  int? hoveredIndex;
  @override
  void initState() {
    super.initState();
    _bookCatalog = fetchBookCatalog();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose one book to review..'),
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: Colors.white,
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
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) {
                    setState(() {
                      hoveredIndex = index;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      hoveredIndex = null;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewFormPage(book: book),
                        ),
                      );
                    },
                    child: Container(
                      margin: hoveredIndex == index ?  const EdgeInsets.symmetric(vertical : 9.0, horizontal: 5.0) : const EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: hoveredIndex == index ? Colors.white : AppTheme.defaultBlue,
                        boxShadow: [ hoveredIndex == index ? 
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 5.0,
                            offset: const Offset(1, 3),
                          ) : 
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 4.0,
                            offset: const Offset(1, 2),
                          )
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
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: hoveredIndex == index ? AppTheme.defaultBlue : AppTheme.defaultYellow,
                                    ),
                                  ),
                                  Text(
                                    book.fields.author,
                                    style: TextStyle(fontSize: 12.0, color: hoveredIndex == index ? AppTheme.defaultBlue : AppTheme.darkBeige,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    home: BookCatalogPage(),
  ));
}