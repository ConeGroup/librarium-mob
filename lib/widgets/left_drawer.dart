import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/menu.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // Bagian drawer header
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Librarium',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Eksplorasi Librarium!",
                  // Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
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
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          // New menu items for Collection, Books Reviews, Book Loans, and Book Request
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text('Collection'),
            onTap: () {
              // Handle redirection to the Collection page
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_mark_rounded),
            title: const Text('Book Request'),
            onTap: () {
              // Handle redirection to the Book Request page
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Book Loans'),
            onTap: () {
              // Handle redirection to the Book Loans page
            },
          ),
          ListTile(
            leading: const Icon(Icons.reviews_rounded),
            title: const Text('Books Reviews'),
            onTap: () {
              // Handle redirection to the Books Reviews page
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle redirection to the Books Reviews page
            },
          ),
        ],
      ),
    );
  }
}
