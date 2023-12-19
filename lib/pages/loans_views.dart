import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:librarium_mob/apptheme.dart';
import 'dart:convert';
import 'package:librarium_mob/models/loans_catalog_models.dart';
import 'package:librarium_mob/models/loans_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LoansViewsPage extends StatefulWidget {
  const LoansViewsPage({Key? key}) : super(key: key);

  @override
  _LoansViewsPageState createState() => _LoansViewsPageState();
}

Future<List<LoansBook>> fetchBook(request) async {
  try {
    var response =
        await request.get("https://librarium-c01-tk.pbp.cs.ui.ac.id/show_loans/get_product_json/");
    List<LoansBook> loanBooks = [];

    for (var res in response) {
      if (res != null) {
        loanBooks.add(LoansBook.fromJson(res));
      }
    }

    return loanBooks;
  } catch (error) {
    throw Exception('Error: $error');
  }
}

Future<List<LoansCatalog>> fetchBookCatalog() async {
  var url = Uri.parse('https://librarium-c01-tk.pbp.cs.ui.ac.id/show_loans/get_book_json/');

  try {
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
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

class _LoansViewsPageState extends State<LoansViewsPage> {
  late Future<List<LoansBook>> _loansBooks;
  late Future<List<LoansCatalog>> _loansCatalog;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    _loansBooks = fetchBook(request);
    _loansCatalog = fetchBookCatalog();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Your Loan Books',
          ),
        ),
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<LoansBook>>(
        future: _loansBooks,
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
            return FutureBuilder<List<LoansCatalog>>(
              future: _loansCatalog,
              builder: (context, AsyncSnapshot<List<LoansCatalog>> bookSnapshot) {
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var loans = snapshot.data![index];
                      var book = bookSnapshot.data!.firstWhere(
                        (book) => book.pk == loans.fields.numberBook,
                        );
                      return LoansListItem(
                        book: book,
                        loans: loans,
                        onDelete: () {
                        },
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


class LoansListItem extends StatelessWidget {
  final LoansCatalog book;
  final LoansBook loans;
  final Function onDelete; // Add this line

  const LoansListItem({
    Key? key,
    required this.book,
    required this.loans,  
    required this.onDelete, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateLoan = DateFormat('yyyy-MM-dd').format(loans.fields.dateLoan);
    String dateReturn = DateFormat('yyyy-MM-dd').format(loans.fields.dateReturn);


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
                  Text(
                    "Date Loan: $dateLoan",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Date Return: $dateReturn",
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
           // Add the Delete button
          
        ],
      ),
    );
  }
}
