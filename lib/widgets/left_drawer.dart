import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/collections/collections_list_page.dart';
import 'package:librarium_mob/pages/menu.dart';
import 'package:librarium_mob/main.dart';
import 'package:librarium_mob/pages/loans_page.dart';
import 'package:librarium_mob/requests/request_page.dart';
import 'package:librarium_mob/pages/reviews/review_page.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:librarium_mob/pages/collections/collections_page.dart';
import 'package:librarium_mob/pages/edit_profile.dart';
import '../pages/menu.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // Bagian drawer header
            decoration: BoxDecoration(
              color: AppTheme.defaultBlue,
            ),
            child: Column(
              children: [
                Text(
                  'Librarium',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.defaultYellow,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Explore with Librarium!",
                  // Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          // Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ));
            },
          ),
          // New menu items for Collection, Books Reviews, Book Loans, and Book Request
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text('Collections'),
            onTap: () {
              // Handle redirection to the Collection page
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CollectionListPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_add_rounded),
            title: const Text('Book Request'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RequestPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Book Loans'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoansPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.reviews_rounded),
            title: const Text('Book Reviews'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReviewPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('User Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final response = await request.logout(
                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                  "http://127.0.0.1:8000/auth/logout/");
              String message = response["message"];
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message See you again, $uname."),
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
            },
          ),
        ],
      ),
    );
  }
}
