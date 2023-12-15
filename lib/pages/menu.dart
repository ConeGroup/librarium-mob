import 'package:flutter/material.dart';
import 'package:librarium_mob/main.dart';
import 'package:librarium_mob/pages/loans_page.dart';
import 'package:librarium_mob/pages/request_page.dart';
import 'package:librarium_mob/pages/register_page.dart';
import 'package:librarium_mob/pages/request_page.dart';
import 'package:librarium_mob/pages/reviews/components/book_scroll.dart';
import 'package:librarium_mob/pages/reviews/list_review.dart';
import 'package:librarium_mob/pages/reviews/review_page.dart';
import 'package:librarium_mob/pages/reviews/review_form.dart';
import 'package:librarium_mob/pages/user_page.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'edit_profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentSelectedIndex = 0;

  final List<LibrariumItem> items = [
    LibrariumItem("Collections", Icons.collections_bookmark),
    LibrariumItem("Book Request", Icons.question_mark_rounded),
    LibrariumItem("Book Loans", Icons.library_books),
    LibrariumItem("Book Reviews", Icons.reviews_rounded),
    LibrariumItem("User Settings", Icons.settings),
    LibrariumItem("Logout", Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

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
      bottomNavigationBar: const BottomNavBarFb1(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: AppTheme.defaultBlue,
                ),
                constraints: const BoxConstraints.expand(height:50.0),
                child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hi! What\'s your agenda today?',
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
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: const PopularBooks(),
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

  const LibrariumCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: AppTheme.defaultBlue,
      borderRadius: BorderRadius.circular(20),
      shadowColor:  const Color.fromRGBO(174, 174, 174, 0.399),

      child: InkWell(
        onTap: () async {
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
                    builder: (context) => RequestPage()));
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
          } else if (item.name == "User Settings") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserPage()));
          } else if (item.name == "Logout") {
            final response = await request.logout(
              // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                "http://127.0.0.1:8000/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message"),
              ));
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.defaultBlue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(174, 174, 174, 0.6),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(1,3), // changes position of shadow
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
      ),
    );
  }
}


class BottomNavBarFb1 extends StatelessWidget {
  const BottomNavBarFb1({Key? key}) : super(key: key);

  final primaryColor = AppTheme.defaultBlue;
  final secondaryColor = const Color(0xff6D28D9);
  final back = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconBottomBar(
                    text: "Book Loans",
                    icon: Icons.feed,
                    selected: false,
                    onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoansPage()));
                    }),
                IconBottomBar(
                    text: "Book Collections",
                    icon: Icons.collections_bookmark,
                    selected: false,
                    onPressed: () {}),
                IconBottomBar2(
                    text: "Home",
                    icon: Icons.home,
                    selected: true,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                    }),
                IconBottomBar(
                    text: "Book Request",
                    icon: Icons.live_help_rounded,
                    selected: false,
                    onPressed: () {}),
                IconBottomBar(
                    text: "User Settings",
                    icon: Icons.account_circle_rounded,
                    selected: false,
                    onPressed: () {})
              ],
            ),
          ),
        ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

 final primaryColor = AppTheme.defaultBlue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final primaryColor = AppTheme.defaultBlue;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}