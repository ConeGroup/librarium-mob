import 'package:flutter/material.dart';
import 'package:librarium_mob/models/request_model.dart';
import 'package:librarium_mob/requests/request_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../../apptheme.dart';
import '../../utils/request_utils/validate_request_image.dart';

class EditRequestForm extends StatefulWidget {
  final BookRequest bookRequest;
  final CookieRequest request;

  EditRequestForm({required this.bookRequest, required this.request, Key? key}) : super(key: key);

  @override
  _EditRequestFormState createState() => _EditRequestFormState();
}

class _EditRequestFormState extends State<EditRequestForm> {
  final _formKey = GlobalKey<FormState>();

  // Your variables for form fields go here
  String _title = "";
  String _author = "";
  int _isbn = 0;
  int _year = 0;
  String _publisher = "";
  String _initialReview = "";
  String _imageM = "";

  final String defaultImage = "https://imagetolink.com/ib/Xc443szDm3.jpg";

  String get defaultImageLink => defaultImage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 15,
      child: SizedBox(
        width: 400,
        height: 600,
        child: ListView(
          padding: const EdgeInsets.only(
              top: 10, bottom: 10, left: 10, right: 10),
          shrinkWrap: true,
          children: <Widget>[
            Container(
                alignment: Alignment.topCenter,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Edit Request',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog when pressed
                        },
                        icon: const Icon(
                            Icons.close_rounded,
                            size: 30
                        ), // Use the close icon
                      ),
                    ),
                  ],
                )

            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.bookRequest.fields.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 225,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                widget.bookRequest.fields.imageM
                            ),
                            onError: (exception, stackTrace) {
                              AssetImage(defaultImageLink);
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      widget.bookRequest.fields.author,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      widget.bookRequest.fields.year,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: widget.bookRequest.fields.title,
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
                            _title = widget.bookRequest.fields.title;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: widget.bookRequest.fields.author,
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
                            _author = widget.bookRequest.fields.author;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: widget.bookRequest.fields.isbn,
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
                            value = widget.bookRequest.fields.isbn;
                            _isbn = int.parse(widget.bookRequest.fields.isbn);
                          }
                          else if (value != null && int.tryParse(value!) == null) {
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
                          hintText: widget.bookRequest.fields.year,
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
                            value = widget.bookRequest.fields.year;
                            _year = int.parse(widget.bookRequest.fields.year);
                          }
                          else if (value != null && int.tryParse(value!) == null) {
                            return "Number type input required";
                          }
                          if (value.length > 4 || value.length < 4) {
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
                          hintText: widget.bookRequest.fields.publisher,
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
                            _publisher = widget.bookRequest.fields.publisher;
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
                          hintText: widget.bookRequest.fields.initialReview,
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
                            _initialReview = widget.bookRequest.fields.initialReview;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Book Cover",
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            _imageM = widget.bookRequest.fields.imageM;
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 28
                              ),
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const RequestPage()),
                              );
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 28
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
                                final response = await widget.request.post(
                                    "https://fazle-ilahi-c01librarium.stndar.dev/book-request/update-request/${widget.bookRequest.pk}/",
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
                              "Update",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
