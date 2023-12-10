import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/loans_page.dart';
import 'package:librarium_mob/pages/reviews/components/book_scroll.dart';
import 'package:librarium_mob/pages/reviews/list_review.dart';
import 'package:librarium_mob/pages/reviews/review_page.dart';
import 'package:librarium_mob/pages/reviews/review_form.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentSelectedIndex = 0;

  final List<LibrariumItem> items = [
    LibrariumItem("Home", Icons.home),
    LibrariumItem("Collections", Icons.collections_bookmark),
    LibrariumItem("Book Request", Icons.question_mark_rounded),
    LibrariumItem("Book Loans", Icons.library_books),
    LibrariumItem("Book Reviews", Icons.reviews_rounded),
    LibrariumItem("User Settings", Icons.settings),
    LibrariumItem("Logout", Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Librarium',
        style: TextStyle(
                    fontSize: 35,
                    color: AppTheme.defaultYellow,
                    fontWeight: FontWeight.bold,
                  ),
              ),
        backgroundColor: AppTheme.defaultBlue,
        toolbarHeight: 60.0,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.defaultBlue,
                ),
                constraints: BoxConstraints.expand(height:50.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hi, <username>! What\'s your agenda today?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
                )
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((LibrariumItem item) {
                  return LibrariumCard(item);
                }).toList(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: const PopularBooks(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentSelectedIndex = index;
          });

          // Navigate to the corresponding route based on the selected index
          if (items[index].name == "Home") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage()));
          }
          else if (items[index].name == "Collections") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReviewPage()));
          } else if (items[index].name == "Book Request") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReviewPage()));
          } else if (items[index].name == "Book Loans") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReviewPage()));
          } else if (items[index].name == "Book Reviews") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReviewPage()));
          } 
        },
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: "Collections",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: "Book Request",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "Book Loans",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews_rounded),
            label: "Book Reviews",
          ),
        ],
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

  const LibrariumCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: AppTheme.defaultBlue,
      borderRadius: BorderRadius.circular(20),
      shadowColor:  const Color.fromRGBO(174, 174, 174, 0.399),

      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("You pressed ${item.name}!")));

          // TODO: Navigate to the corresponding route based on the item
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
                    builder: (context) => const ReviewPage()));
          } else if (item.name == "User Settings") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReviewFormPage()));
          } else if (item.name == "Logout") {
            // Handle logout
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.defaultBlue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(174, 174, 174, 0.6),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(1,3), // changes position of shadow
              ),
            ],
          ),
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
