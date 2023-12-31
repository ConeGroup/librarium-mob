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
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isHoveredLogin = false;
  bool isHoveredRegister = false;
  bool isHoveredEnter = false;

  MouseCursor _cursorTypeLogin = SystemMouseCursors.basic;
  MouseCursor _cursorTypeRegister = SystemMouseCursors.basic;
  MouseCursor _cursorTypeEnter = SystemMouseCursors.basic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/librarium-logo.png',
                height: 150,
              ),
            ],
          ),
          const Text(
            'Librarium',
            style: TextStyle(
              color: AppTheme.defaultBlue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 100),

          // Login Button
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },

            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHoveredLogin = true;
                  _cursorTypeLogin = SystemMouseCursors.click;
                });
              },
              onExit: (_) {
                setState(() {
                  isHoveredLogin = false;
                  _cursorTypeLogin = SystemMouseCursors.basic;
                });
              },
              cursor: _cursorTypeLogin,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isHoveredLogin ? Colors.black : AppTheme.defaultBlue,
                    width: 3,
                  ),
                  color: isHoveredLogin ? Colors.white : AppTheme.defaultBlue,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.login,
                        color: isHoveredLogin ? Colors.black : Colors.white,
                        size: 30.0,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: isHoveredLogin ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Register Button
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },

            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHoveredRegister = true;
                  _cursorTypeRegister = SystemMouseCursors.click;
                });
              },
              onExit: (_) {
                setState(() {
                  isHoveredRegister = false;
                  _cursorTypeRegister = SystemMouseCursors.basic;
                });
              },
              cursor: _cursorTypeRegister,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isHoveredRegister ? Colors.black : AppTheme.defaultBlue,
                    width: 3,
                  ),
                  color: isHoveredRegister ? Colors.white : AppTheme.defaultBlue,
                  borderRadius: BorderRadius.circular(40),


                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.app_registration,
                        color: isHoveredRegister ? Colors.black : Colors.white,
                        size: 30.0,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Register',
                        style: TextStyle(
                          color: isHoveredRegister ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
