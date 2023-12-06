import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/review_catalog.dart';
import 'package:librarium_mob/pages/list_review.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({Key? key}) : super(key: key);

  final List<ReviewPageItem> items = [
    ReviewPageItem("Add Review", Icons.add_comment),
    ReviewPageItem("Review by Catalog", Icons.book_online_outlined),
    ReviewPageItem("Your Reviews", Icons.reviews_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Librarium',
        ),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Review Page', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: AppTheme.defaultYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ReviewPageItem item) {
                  // Iterasi untuk setiap item
                  return ReviewPageCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewPageItem {
  final String name;
  final IconData icon;

  ReviewPageItem(this.name, this.icon);
}

class ReviewPageCard extends StatelessWidget {
  final ReviewPageItem item;

  const ReviewPageCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.defaultBlue,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // TODO: Navigate ke route yang sesuai (tergantung jenis tombol)
          // isi sesuai modul yang dikerjakan masing-masing
          if (item.name == "Your Reviews") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReviewListPage()));
          }
          else if (item.name == "Review by Catalog") {  // Handle the new item
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookCatalogPage()));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
