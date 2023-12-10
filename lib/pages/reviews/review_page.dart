import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/reviews/components/book_scroll.dart';
import 'package:librarium_mob/pages/reviews/components/user_reviews.dart';
import 'package:librarium_mob/pages/reviews/review_catalog.dart';
import 'package:librarium_mob/pages/reviews/list_review.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class ReviewPage extends StatelessWidget {
  ReviewPage({Key? key}) : super(key: key);

  final List<ReviewPageItem> items = [
    ReviewPageItem("Add Review", Icons.add_comment),
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: appBar,
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Book Reviews', 
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
                    ]
                  ),
                ),
              ),
              ListView(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.symmetric(vertical:10.0, horizontal:20.0),
                shrinkWrap: true,
                children: items.map((ReviewPageItem item) {
                  // Iterasi untuk setiap item
                  return ReviewPageCard(item);
                }).toList(),
              ),
              // const PopularBooks(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: RecentReviews(),
              ),              // Grid layout
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
      borderRadius: BorderRadius.circular(30),
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
          else if (item.name == "Add Review") {  // Handle the new item
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookCatalogPage()));
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: AppTheme.defaultBlue,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(174, 174, 174, 0.6),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(1,3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
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
                  style: const TextStyle(color: AppTheme.defaultYellow),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
