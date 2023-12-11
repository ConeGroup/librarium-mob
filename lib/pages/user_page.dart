import 'package:flutter/material.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      drawer: LeftDrawer(), // Gantilah dengan drawer yang sesuai
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Pengguna
            Text(
              'Informasi Pengguna:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Tambahkan widget untuk menampilkan informasi pengguna seperti nama, email, dll.

            // Pengaturan
            SizedBox(height: 16),
            Text(
              'Pengaturan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              title: Text('Notifikasi'),
              onTap: () {
                // Tambahkan logika untuk navigasi atau tindakan lainnya
              },
            ),
            ListTile(
              title: Text('Bahasa'),
              onTap: () {
                // Tambahkan logika untuk navigasi atau tindakan lainnya
              },
            ),

            // Kebijakan Privasi
            SizedBox(height: 16),
            Text(
              'Kebijakan Privasi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              title: Text('Privasi'),
              onTap: () {
                // Tambahkan logika untuk navigasi atau tindakan lainnya
              },
            ),
          ],
        ),
      ),
    );
  }
}
