import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:librarium_mob/models/loans_catalog_models.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';

class LoansCatalogPage extends StatefulWidget {
  const LoansCatalogPage({Key? key}) : super(key: key);

  @override
  _LoansCatalogPageState createState() => _LoansCatalogPageState();
}

class _LoansCatalogPageState extends State<LoansCatalogPage> {
  Future<List<LoansCatalog>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('http://localhost:8000/show_loans/get_book_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<LoansCatalog> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(LoansCatalog.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => InkWell(
                          onTap: () {
                            // // Navigate ke detail page
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => DetailPage(
                            //       itemName: snapshot.data![index].fields.name,
                            //       price: snapshot.data![index].fields.price,
                            //       itemDescription:
                            //           snapshot.data![index].fields.description,
                            //       itemAmount:
                            //           snapshot.data![index].fields.amount,
                            //       // Pass more data if needed
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.year}"),
                                const SizedBox(height: 10),
                                Text(
                                    "${snapshot.data![index].fields.author}"),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.publisher}")
                              ],
                            ),
                          )));
                }
              }
            }));
  }
}
