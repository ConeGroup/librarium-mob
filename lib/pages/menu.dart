import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/list_review.dart';
import 'package:librarium_mob/pages/review_page.dart';
import 'package:librarium_mob/pages/review_form.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/pages/loans_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<LibrariumItem> items = [
    LibrariumItem("Collections", Icons.collections_bookmark),
    LibrariumItem("Book Request", Icons.question_mark_rounded),
    LibrariumItem("Book Loans", Icons.library_books),
    LibrariumItem("Book Reviews", Icons.reviews_rounded),
    LibrariumItem("Logout", Icons.logout),
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
                  'Librarium', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: AppTheme.defaultYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),              
              ),
              const Text(
                'Hi, <username>! What\'s your agenda today?',
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme.defaultBlue,
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
                children: items.map((LibrariumItem item) {
                  // Iterasi untuk setiap item
                  return LibrariumCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibrariumItem {
  final String name;
  final IconData icon;

  LibrariumItem(this.name, this.icon);
}

class LibrariumCard extends StatelessWidget {
  final LibrariumItem item;

  const LibrariumCard(this.item, {super.key}); // Constructor

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
          if (item.name == "Collections") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReviewPage()));
          } else if (item.name == "Book Request") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReviewPage()));
          } else if (item.name == "Book Loans") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoansPage()));
          } else if (item.name == "Book Reviews") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReviewPage()));
          } else if (item.name == "Logout") {}
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
                  color: AppTheme.defaultYellow,
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
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
