// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:librarium_mob/models/loans_catalog_models.dart';
// import 'package:librarium_mob/widgets/left_drawer.dart';
// import 'package:librarium_mob/apptheme.dart';

// class LoansCatalogPage extends StatefulWidget {
//   const LoansCatalogPage({Key? key}) : super(key: key);

//   @override
//   _LoansCatalogPageState createState() => _LoansCatalogPageState();
// }

// class _LoansCatalogPageState extends State<LoansCatalogPage> {
//   Future<List<LoansCatalog>> fetchProduct() async {
//     // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
//     var url = Uri.parse('http://localhost:8000/show_loans/get_book_json/');
//     var response = await http.get(
//       url,
//       headers: {"Content-Type": "application/json"},
//     );

//     // melakukan decode response menjadi bentuk json
//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     // melakukan konversi data json menjadi object Product
//     List<LoansCatalog> list_product = [];
//     for (var d in data) {
//       if (d != null) {
//         list_product.add(LoansCatalog.fromJson(d));
//       }
//     }
//     return list_product;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: appBar,
//         drawer: const LeftDrawer(),
//         body: FutureBuilder(
//             future: fetchProduct(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return const Center(child: CircularProgressIndicator());
//               } else {
//                 if (!snapshot.hasData) {
//                   return const Column(
//                     children: [
//                       Text(
//                         "Tidak ada data produk.",
//                         style:
//                             TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                       ),
//                       SizedBox(height: 8),
//                     ],
//                   );
//                 } else {
//                   return ListView.builder(
                    
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (_, index) => InkWell(
//                           onTap: () {},
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 12),
//                             padding: const EdgeInsets.all(20.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "${snapshot.data![index].fields.title}",
//                                   style: const TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text("${snapshot.data![index].fields.year}"),
//                                 const SizedBox(height: 10),
//                                 Text("${snapshot.data![index].fields.author}"),
//                                 const SizedBox(height: 10),
//                                 Text("${snapshot.data![index].fields.publisher}"),
//                                 const SizedBox(height: 10),
//                                 Text("${snapshot.data![index].pk}"),
//                               ],
//                             ),
//                           )));
//                 }
//               }
//             }));
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librarium_mob/apptheme.dart';
import 'dart:convert';
import 'package:librarium_mob/models/loans_catalog_models.dart';

class LoansCatalogPage extends StatefulWidget {
  const LoansCatalogPage({Key? key}) : super(key: key);

  @override
  _LoansCatalogPageState createState() => _LoansCatalogPageState();
}

class _LoansCatalogPageState extends State<LoansCatalogPage> {
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
            'Available Book to Loans',
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ReviewFormPage(book: book),
                    //   ),
                    // );
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
                                Text(
                                  book.pk.toString(),
                                  style: TextStyle(fontSize: 12.0, color: AppTheme.darkBeige),
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
    home: LoansCatalogPage(),
  ));
}

