import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librarium_mob/apptheme.dart';
import 'dart:convert';
import 'package:librarium_mob/models/request_model.dart';
import 'package:librarium_mob/pages/request_form.dart';
import 'package:librarium_mob/utils/fetch_request.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _author = "";
  int _isbn = 0;
  int _year = 0;
  String _publisher = "";
  String _initialReview = "";
  String _imageM = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Request'),
          actions: <Widget> [
            IconButton(
              icon: Row(
                children: <Widget>[
                  Icon(Icons.add),
                  SizedBox(width: 5),
                  Text('Add Request'),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RequestFormPage()),
                );
              },
            ),
          ],
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchRequest(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You don't have any request.",
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(color: AppTheme.defaultBlue, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Request'),
                          onPressed: () {
                            // Add your onPressed logic here
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>
                              const RequestFormPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data![index].fields.title}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.author}"),
                            const SizedBox(height: 10),
                            Text(
                                "${snapshot.data![index].fields.year}"
                            ),
                            const SizedBox(height: 10),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.indigo),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Review'),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${snapshot.data![index].
                                                        fields.initialReview}"
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "See Review",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.indigo),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Confirmation'),
                                              content: const SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Are you sure?"
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Yes'),
                                                  onPressed: () async {
                                                    await request.get(
                                                        "http://127.0.0.1:8000/book-request/remove-request/${snapshot.data![index].pk}/").then(
                                                          (value) => {
                                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RequestPage())),
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return Dialog(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  elevation: 15,
                                                                  child: ListView(
                                                                    padding: const EdgeInsets.only(
                                                                        top: 20, bottom: 20),
                                                                    shrinkWrap: true,
                                                                    children: <Widget>[
                                                                      const Center(
                                                                          child: Text('Request removed succesfully')),
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
                                                            )
                                                          },
                                                    );
                                                    },
                                                ),
                                                TextButton(
                                                  child: const Text('No'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "Remove",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.indigo),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                elevation: 15,
                                                child: ListView(
                                                  padding: const EdgeInsets.only(
                                                      top: 20, bottom: 20),
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    const Center(
                                                        child: Text('Edit')),
                                                    const SizedBox(height: 20),

                                                    Form(
                                                      key: _formKey,
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                decoration: InputDecoration(
                                                                  hintText: "${snapshot.data![index].fields.title}",
                                                                  labelText: "Book Title",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                  ),
                                                                ),
                                                                onChanged: (String? value) {
                                                                  setState(() {
                                                                    _title = value!;
                                                                  });
                                                                },
                                                                validator: (String? value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    _title = "${snapshot.data![index].fields.title}";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                decoration: InputDecoration(
                                                                  hintText: "${snapshot.data![index].fields.author}",
                                                                  labelText: "Author",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5.0),
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
                                                                    _author = "${snapshot.data![index].fields.author}";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                decoration: InputDecoration(
                                                                  hintText: "${snapshot.data![index].fields.isbn}",
                                                                  labelText: "ISBN",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5.0),
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
                                                                    value = "${snapshot.data![index].fields.isbn}";
                                                                    _isbn = int.parse("${snapshot.data![index].fields.isbn}");
                                                                  }
                                                                  else if (value != null && int.tryParse(value!) == null) {
                                                                    return "Number type input required";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                decoration: InputDecoration(
                                                                  hintText: "${snapshot.data![index].fields.year}",
                                                                  labelText: "Year",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5.0),
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
                                                                    value = "${snapshot.data![index].fields.year}";
                                                                    _year = int.parse("${snapshot.data![index].fields.year}");
                                                                  }
                                                                  else if (value != null && int.tryParse(value!) == null) {
                                                                    return "Number type input required";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                decoration: InputDecoration(
                                                                  hintText: "${snapshot.data![index].fields.publisher}",
                                                                  labelText: "Publisher",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5.0),
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
                                                                    _publisher = "${snapshot.data![index].fields.publisher}";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                decoration: InputDecoration(
                                                                  hintText: "${snapshot.data![index].fields.initialReview}",
                                                                  labelText: "Short Review",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5.0),
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
                                                                    _initialReview = "${snapshot.data![index].fields.initialReview}";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                decoration: InputDecoration(
                                                                  hintText: "${snapshot.data![index].fields.imageM}",
                                                                  labelText: "Book Cover",
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                  ),
                                                                ),
                                                                onChanged: (String? value) {
                                                                  setState(() {
                                                                    // TODO: Tambahkan variabel yang sesuai
                                                                    _imageM = value!;
                                                                  });
                                                                },
                                                                validator: (String? value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    _imageM = "${snapshot.data![index].fields.imageM}";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment.bottomCenter,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: ElevatedButton(
                                                                  style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                                                                  ),
                                                                  onPressed: () async {
                                                                    if (_formKey.currentState!.validate()) {
                                                                      final response = await request.post(
                                                                        "http://127.0.0.1:8000/book-request/update-request/${snapshot.data![index].pk}/",
                                                                        {
                                                                          'title': _title,
                                                                          'author': _author,
                                                                          'isbn': _isbn.toString(),
                                                                          'year': _year.toString(),
                                                                          'publisher': _publisher,
                                                                          'initial_review': _initialReview,
                                                                          'image_m': _imageM,
                                                                        });
                                                                      if (response['status'] == 'success') {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(const SnackBar(
                                                                          content: Text("Request updated!"),
                                                                        ));
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
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => const RequestPage())
                                                        );
                                                      },
                                                      child: const Text('Back'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                        );
                                      },
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //
                          ],
                        ),
                      ));
                }
              }
            }
            )
    );
  }
}
