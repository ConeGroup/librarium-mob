import 'package:flutter/material.dart';
// import 'package:librarium_mob/models/review_model.dart';
import 'package:librarium_mob/pages/collections/collections_form.dart';
import 'package:librarium_mob/pages/reviews/review_page.dart';
// import 'package:librarium_mob/pages/reviews/review_form.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/pages/collections/collections_form.dart';
// import 'package:librarium_mob/pages/loans_catalog_pages.dart';

class CollectionsPage extends StatelessWidget {
  CollectionsPage({Key? key}) : super(key: key);

  final List<CollectionsItem> items = [
    CollectionsItem("View Collections", Icons.collections_bookmark_rounded),
    CollectionsItem("Add Collections", Icons.add_box_outlined),
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
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: items.map((CollectionsItem item) {
                  // Iterasi untuk setiap item
                  return CollectionsCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CollectionsItem {
  final String name;
  final IconData icon;

  CollectionsItem(this.name, this.icon);
}

class CollectionsCard extends StatelessWidget {
  final CollectionsItem item;

  const CollectionsCard(this.item, {super.key}); // Constructor

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
          if (item.name == "View Collections") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>   ReviewPage()));
          } else if (item.name == "Add Collections") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  CollectionFormPage()));
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
