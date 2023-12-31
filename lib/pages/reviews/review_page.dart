import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/menu.dart';
import 'package:librarium_mob/pages/reviews/components/floating_button.dart';
import 'package:librarium_mob/pages/reviews/components/user_reviews.dart';
import 'package:librarium_mob/pages/reviews/review_catalog.dart';
import 'package:librarium_mob/pages/reviews/reviews.dart';
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
      appBar: const AppBarBuild(),
      drawer: const LeftDrawer(),
      bottomNavigationBar: const BottomNavBarFb1(),
      floatingActionButton: const FloatingAddReviewBtn(),
      floatingActionButtonLocation:    
          FloatingActionButtonLocation.endFloat,
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
              const Text(
                "Uncover the world of books through insightful reviews. \n Share your thoughts and discover your next great read!",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.defaultBlue,
                    fontWeight: FontWeight.normal,
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
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: const AllBookReviews(),
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

class ReviewPageCard extends StatefulWidget {
  final ReviewPageItem item;

  const ReviewPageCard(this.item, {super.key});

  @override
  _ReviewPageCardState createState() => _ReviewPageCardState();
}

class _ReviewPageCardState extends State<ReviewPageCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: GestureDetector(
            onTap: () {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text("Kamu telah menekan tombol ${widget.item.name}!")));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookCatalogPage()),
              );
            },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: isHovered ? Colors.white : AppTheme.defaultBlue,
              border: Border.all(color: AppTheme.defaultBlue, width: 3),
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(174, 174, 174, 0.6),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.item.icon,
                    color: isHovered ? AppTheme.defaultBlue : AppTheme.defaultYellow,
                    size: 30.0,
                  ),
                  const Padding(padding: EdgeInsets.all(3)),
                  Text(
                    widget.item.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isHovered ? AppTheme.defaultBlue : AppTheme.defaultYellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool hovered) {
    setState(() {
      isHovered = hovered;
    });
  }
}
