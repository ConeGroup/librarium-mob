import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/menu.dart';
import 'package:librarium_mob/pages/reviews/list_review.dart';
import 'package:librarium_mob/pages/reviews/review_catalog.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var requestglobal;

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      });
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
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          controller: _tabController,
          tabs: [
            Tab(text: 'User Profile'),
            Tab(text: 'Change Password'),
            Tab(text: 'Edit Email'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBarFb1(),
      drawer: const LeftDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          UserProfileContent(),
          EditUsernamePasswordContent(),
          EditEmailContent(),
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
    requestglobal = request;
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
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController =
      TextEditingController();

  // final storage = new FlutterSecureStorage();

  void showAlert(String message, String category) {
    // Implementasikan fungsi ini sesuai dengan kebutuhan Anda
  }

  Future<void> savePassword(String oldPassword, String newPassword,
      String newPasswordConfirm, BuildContext context) async {
    if (oldPassword.isEmpty ||
        newPassword.isEmpty ||
        newPasswordConfirm.isEmpty) {
      showAlert("Please fill the form!", 'warning');
      return;
    }
    if (newPassword != newPasswordConfirm) {
      showAlert('Wrong confirm Password', 'warning');
      return;
    }

    String url = "http://127.0.0.1:8000/userprofile/api/change_password/";
    // String token = await storage.read(key: "token");
    // print(requestglobal);
    // print(oldPassword);
    // print(newPassword);
    // print(newPasswordConfirm);

    // var response = await requestglobal.postJson(
    //   Uri.parse(url),
    //   body: <String, String>{
    //     'old_password': oldPassword,
    //     'new_password1': newPassword,
    //     'new_password2': newPasswordConfirm,
    //   },
    // );

    var response = await requestglobal.postJson(
        "http://127.0.0.1:8000/userprofile/api/change_password/",
        jsonEncode(<String, String>{
          'old_password': oldPassword,
          'new_password1': newPassword,
          'new_password2': newPasswordConfirm,
        }));

    if (response['message'] == 'Password successfully changed') {
      // Password changed successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password has been successfully changed!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Handle other status codes if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Change Your Password',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _oldPasswordController,
            decoration: InputDecoration(labelText: 'Old Password'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _newPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'New Password'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _newPasswordConfirmController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Confirm New Password'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              savePassword(
                _oldPasswordController.text,
                _newPasswordController.text,
                _newPasswordConfirmController.text,
                context,
              );
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}

class EditEmailContent extends StatelessWidget {
  final TextEditingController _newEmailController = TextEditingController();

  // final storage = new FlutterSecureStorage();

  void showAlert(String message, String category) {
    // Implementasikan fungsi ini sesuai dengan kebutuhan Anda
  }

  Future<void> saveEmail(String newEmail, BuildContext context) async {
    if (newEmail.isEmpty) {
      showAlert("Please fill the form!", 'warning');
      return;
    }

    String url = "http://127.0.0.1:8000/userprofile/api/edit_profile/";
    // String token = await storage.read(key: "token");
    // print(requestglobal);
    // print(oldPassword);
    // print(newPassword);
    // print(newPasswordConfirm);

    // var response = await requestglobal.postJson(
    //   Uri.parse(url),
    //   body: <String, String>{
    //     'old_password': oldPassword,
    //     'new_password1': newPassword,
    //     'new_password2': newPasswordConfirm,
    //   },
    // );

    var response = await requestglobal.postJson(
        "http://127.0.0.1:8000/userprofile/api/edit_profile/",
        jsonEncode(<String, String>{
          'username': requestglobal.jsonData["username"],
          'email': newEmail,
        }));

    requestglobal.jsonData['email'] = newEmail;
    if (response['message'] == 'Email successfully changed') {
      // Password changed successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email has been successfully changed!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Handle other status codes if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Change Your Email',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _newEmailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              saveEmail(
                _newEmailController.text,
                context,
              );
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
