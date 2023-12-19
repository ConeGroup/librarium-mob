import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/requests/request_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../utils/request_utils/validate_request_image.dart';

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key});

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _author = "";
  int _isbn = 0;
  int _year = 0;
  String _publisher = "";
  String _initialReview = "";
  String _imageM = "";

  final String defaultImage = "https://img.freepik.com/free-psd/3d-rendering-"
      "back-school-icon_23-2149589337.jpg?w=740&t=st=1702892479~exp=1702893079~"
      "hmac=23a92c816c97af49db0a81d320c015c31c53ec3bddf9d116464b6a4afe0650e7";

  String get defaultImageLink => defaultImage;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Request Form',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: AppTheme.defaultYellow,
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Book Title",
                    labelText: "Book Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert the book title.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Author",
                    labelText: "Author",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // TODO: Tambahkan variabel yang sesuai
                  onChanged: (String? value) {
                    setState(() {
                      _author = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert the author of the book";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "ISBN",
                    labelText: "ISBN",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // TODO: Tambahkan variabel yang sesuai
                  onChanged: (String? value) {
                    setState(() {
                      _isbn = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert the book's ISBN.";
                    }
                    if (int.tryParse(value) == null) {
                      return "Number type input required";
                    }
                    if (value.length > 13 || value.length < 10) {
                      return "ISBN is a 10-13 series number.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Year",
                    labelText: "Year",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // TODO: Tambahkan variabel yang sesuai
                  onChanged: (String? value) {
                    setState(() {
                      _year = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert the year of book publication.";
                    }
                    if (int.tryParse(value) == null) {
                      return "Number type input required";
                    }
                    if (value.length < 4 || value.length > 4) {
                      return "Please insert a valid year.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Publisher",
                    labelText: "Publisher",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // TODO: Tambahkan variabel yang sesuai
                  onChanged: (String? value) {
                    setState(() {
                      _publisher = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert the book publisher.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 9,
                  minLines: 6,
                  decoration: InputDecoration(
                    hintText: "Tell us how good this book is.",
                    labelText: "Short Review",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      // TODO: Tambahkan variabel yang sesuai
                      _initialReview = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please insert your short review.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Insert a valid image link or leave it blank.",
                    labelText: "Book's Image Link",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      // TODO: Tambahkan variabel yang sesuai
                      _imageM = value!;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 48
                      ),
                      backgroundColor: AppTheme.defaultBlue,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Validate the image link before sending the request
                        bool isValidImageLink = await validateImageLink(_imageM);

                        if (!isValidImageLink) {
                          // Set a default image link if the provided link is invalid
                          _imageM = defaultImageLink;
                        }
                        // Kirim ke Django dan tunggu respons
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        final response = await request.postJson(
                            "http://127.0.0.1:8000/book-request/create-flutter/",
                            jsonEncode(<String, String>{
                              // TODO: Sesuaikan field data sesuai dengan aplikasimu
                              'title': _title,
                              'author': _author,
                              'isbn': _isbn.toString(),
                              'year': _year.toString(),
                              'publisher': _publisher,
                              'initial_review': _initialReview,
                              'image_m': _imageM,
                              // 'user': loggedInUsername,
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Request saved"),
                          ));
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                            Text("An error occurred, please try again."),
                          ));
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
