import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/loans_form.dart';
import 'package:librarium_mob/pages/menu.dart';
import 'package:librarium_mob/pages/reviews/review_form.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/pages/loans_catalog_pages.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:librarium_mob/pages/loans_views.dart';

class LoansPage extends StatelessWidget {
  LoansPage({Key? key}) : super(key: key);

  final List<LoansItem> items = [
    LoansItem("myLoans", Icons.collections_bookmark_rounded),
    LoansItem("Add Loans", Icons.add_box_outlined),
    LoansItem("Catalog", Icons.bookmark),
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: appBar,
      drawer: const LeftDrawer(),
      bottomNavigationBar: const BottomNavBarFb1(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 30.0, horizontal: 20.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Book Loans',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 30,
                      color: AppTheme.defaultBlue,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          offset: Offset(0, 2),
                        ),
                      ]),
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
                children: items.map((LoansItem item) {
                  // Iterasi untuk setiap item
                  return LoansCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoansItem {
  final String name;
  final IconData icon;

  LoansItem(this.name, this.icon);
}

class LoansCard extends StatelessWidget {
  final LoansItem item;

  const LoansCard(this.item, {super.key}); // Constructor

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
          if (item.name == "myLoans") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoansViewsPage()));
          } else if (item.name == "Add Loans") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoansFormPage()));
          } else if (item.name == "Catalog") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoansCatalogPage()));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text90jb8t
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
