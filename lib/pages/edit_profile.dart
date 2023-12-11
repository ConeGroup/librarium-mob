import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/reviews/list_review.dart';
import 'package:librarium_mob/pages/reviews/review_catalog.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Librarium'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'User Profile'),
            Tab(text: 'Edit Username and Email'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UserProfileContent(),
          EditUsernamePasswordContent(),
        ],
      ),
    );
  }
}

class UserProfileContent extends StatefulWidget {
  @override
  _UserProfileContentState createState() => _UserProfileContentState();
}

class _UserProfileContentState extends State<UserProfileContent> {
  Map<String, dynamic> userProfileData = {};

  int? Countloansbook;
  int? CountReviewBook;
  int? CountRequestBook;

  Future<void> fetchUserProfileData() async {
    final request = context.watch<CookieRequest>();
    final response = await request
        .get('http://127.0.0.1:8000/userprofile/api/show_userprofile/');
    Countloansbook = response['CountLoansBook'];
    CountReviewBook = response['CountReviewBook'];
    CountRequestBook = response['CountRequestBook'];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return FutureBuilder(
      future: fetchUserProfileData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildProfileInfo('User Name', request.jsonData['username']),
                  _buildProfileInfo('Email', request.jsonData['email']),
                  _buildProfileInfo(
                      'Number of Loan Books', Countloansbook.toString()),
                  _buildProfileInfo(
                      'Number of Review Books', CountReviewBook.toString()),
                  _buildProfileInfo(
                      'Number of Request Books', CountRequestBook.toString()),
                  Spacer(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildProfileInfo(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class EditUsernamePasswordContent extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Edit Your Username and Email',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Changes saved!');
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
