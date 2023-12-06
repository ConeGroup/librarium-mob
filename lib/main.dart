import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/pages/login_page.dart';
import 'package:librarium_mob/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppTheme.defaultBlue),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const HomePage(title: 'Welcome'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () =>
                    {Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    )},
                    child: const Text("Login",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () =>
                    {Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    )},
                    child: const Text("Register",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () =>
                    {Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    )},
                    child: const Text("Enter as Guest",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              )
            ],
          ),
        ],
      ),
    );
  }
}
