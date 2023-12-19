import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/models/request_model.dart';
import 'package:librarium_mob/widgets/request_widget/edit_request_form.dart';
import 'package:librarium_mob/requests/request_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class RequestListItem extends StatelessWidget {
  final BookRequest bookRequest;
  final CookieRequest request;

  const RequestListItem({
    super.key,
    required this.bookRequest,
    required this.request
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Right side (book image)
          Container(
            width: 125,
            height: 175,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
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
                fit: BoxFit.cover,
                image: NetworkImage(bookRequest.fields.imageM),
              ),
            ),
          ),
          // Left side (book details)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookRequest.fields.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "by ${bookRequest.fields.author}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bookRequest.fields.year,
                    style: const TextStyle(fontSize: 12),
                  ),
                  // const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Container(
            width: 125,
            height: 175,
            margin: const EdgeInsets.symmetric(
              // horizontal: 8,
              vertical: 10,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.info_rounded),
                    color: AppTheme.defaultBlue,
                    iconSize: 32,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'Book Details',
                              style: TextStyle(fontSize: 18),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    bookRequest.fields.title,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    bookRequest.fields.author,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    bookRequest.fields.year,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    height: 275,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            bookRequest.fields.imageM
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "ISBN",
                                              textAlign: TextAlign.start
                                          ),
                                          Text(
                                              "Publisher",
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              " : ",
                                              textAlign: TextAlign.center
                                          ),
                                          Text(
                                            " : ",
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(bookRequest.fields.isbn),
                                          Text(bookRequest.fields.publisher),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  BookReviewWidget(
                                      bookRequest.fields.initialReview
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_note_rounded),
                        color: AppTheme.defaultBlue,
                        iconSize: 32,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return EditRequestForm(
                                bookRequest: bookRequest,
                                request: request,
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_rounded),
                        color: Colors.red,
                        iconSize: 32,
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
                                          "https://librarium-c01-tk.pbp.cs.ui.ac.id/book-request/remove-request/${bookRequest.pk}/")
                                          .then((value) => {
                                          Navigator.pop(context),
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context)
                                                  => const RequestPage())),
                                      ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                      const SnackBar(content:
                                      Text('Request removed succesfully'))),
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
                      ),
                    ],
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
}

class BookReviewWidget extends StatefulWidget {
  final String initialReview;
  BookReviewWidget(this.initialReview, {super.key});

  @override
  _BookReviewWidgetState createState() => _BookReviewWidgetState();
}

class _BookReviewWidgetState extends State<BookReviewWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'My review',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Icon(_isExpanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded),
                )
              ],
            ),
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        _isExpanded ? buildExpandedReviews() : const SizedBox.shrink(),
      ],
    );
  }

  Widget buildExpandedReviews() {
    return Card(
      child: ListTile(
        title: Text(
            widget.initialReview,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}