import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../apptheme.dart';
import 'login_page.dart';

Map<String, dynamic> userData = {"is_taken": false};

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String username = "";
  String email = "";
  // String fName = "";
  // String lName = "";
  String pass1 = "";
  String pass2 = "";

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
            // Logo
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/librarium-logo.png',
                  height: 125,
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

            const SizedBox(height: 50),

            Text(
              'Account Registration',
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),

            const SizedBox(height: 15),

            Form(
              key: _registerFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // Username Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Username",
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              username = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              username = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input your username';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Email Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Email",
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              email = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              email = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input your email';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        TextFormField(
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                togglePasswordView();
                              },
                              child: Icon(isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              pass1 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              pass1 = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input your password';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Confirm Pass Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        TextFormField(
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: "Repeat Password",
                            labelText: "Repeat Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                togglePasswordView();
                              },
                              child: Icon(isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              pass2 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              pass2 = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please repeat your password';
                            } else if (value != pass1) {
                              return 'Wrong password';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Register Button
                  GestureDetector(
                    onTap: () async {
                      if (_registerFormKey.currentState!.validate()) {
                        final response = await request.post(
                            "https://fazle-ilahi-c01librarium.stndar.dev/auth/registerFlutter/",
                            convert.jsonEncode({
                              'username': username,
                              'email': email,
                              'password1': pass1,
                              'password2': pass2,
                            }));
                        if (response['status'] == 'success') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                elevation: 15,
                                child: ListView(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    const Center(
                                        child: Text(
                                            'Account Succesfully Created!')),
                                    const SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const LoginPage()),
                                        );
                                      },
                                      child: const Text('Login Page'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (response['status'] == 'isTaken') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                elevation: 15,
                                child: ListView(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    const Center(
                                        child: Text(
                                            'The username is already taken')),
                                    const SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Back'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                elevation: 15,
                                child: ListView(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    const Center(
                                        child: Text(
                                            'An error occurred, please try again')),
                                    const SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Back'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
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
                            'Register',
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

                  // Sign In Here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a Member?',
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
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Login Here',
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
          ],
        ),
      ),
    );
  }
}
