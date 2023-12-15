// import 'dart:html';

import 'package:librarium_mob/pages/menu.dart';
import 'package:librarium_mob/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../apptheme.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isHovered = false;
  MouseCursor _cursorType = SystemMouseCursors.basic;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/librarium-logo.png',
                  height: 150,
                ),
              ],
            ),
            Text(
              'Librarium',
              style: TextStyle(
                color: AppTheme.defaultBlue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),

            Text(
              'Welcome back, you\'ve been missed!',
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),

            const SizedBox(height: 25),

            // Username TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppTheme.defaultBlue),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Username',
                    hintStyle: TextStyle(color: AppTheme.defaultBlue)),
              ),
            ),

            const SizedBox(height: 10),

            // Password TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppTheme.defaultBlue),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: AppTheme.defaultBlue),
                ),
                obscureText: true,
              ),
            ),

            const SizedBox(height: 20),

            // Sign In Button
            GestureDetector(
              onTap: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Cek kredensial
                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                // gunakan URL http://10.0.2.2/
                final response =
                    await request.login("http://127.0.0.1:8000/auth/login/", {
                  'username': username,
                  'password': password,
                });

                if (request.loggedIn) {
                  String message = response['message'];
                  String uname = response['username'];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("$message Welcome, $uname.")));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Failed'),
                      content: Text(response['message']),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },

              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    isHovered = true;
                    _cursorType = SystemMouseCursors.click;
                  });
                },
                onExit: (_) {
                  setState(() {
                    isHovered = false;
                    _cursorType = SystemMouseCursors.basic;
                  });
                },
                cursor: _cursorType,
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isHovered ? Colors.black : AppTheme.defaultBlue,
                      width: 3,
                    ),
                    color: isHovered ? Colors.white : AppTheme.defaultBlue,
                    borderRadius: BorderRadius.circular(40),


                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: isHovered ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Create Account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'First Time Here?',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 3),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Register Now',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
