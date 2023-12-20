// To parse this JSON data, do
//
//     final bookRequest = bookRequestFromJson(jsonString);

import 'dart:convert';

List<BookRequest> bookRequestFromJson(String str) => List<BookRequest>.from(json.decode(str).map((x) => BookRequest.fromJson(x)));

String bookRequestToJson(List<BookRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookRequest {
  String model;
  int pk;
  Fields fields;

  BookRequest({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory BookRequest.fromJson(Map<String, dynamic> json) => BookRequest(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  String title;
  String author;
  String isbn;
  String year;
  String publisher;
  String initialReview;
  dynamic imageS;
  String imageM;
  dynamic imageL;
  int user;

  Fields({
    required this.title,
    required this.author,
    required this.isbn,
    required this.year,
    required this.publisher,
    required this.initialReview,
    required this.imageS,
    required this.imageM,
    required this.imageL,
    required this.user,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    title: json["title"],
    author: json["author"],
    isbn: json["isbn"],
    year: json["year"],
    publisher: json["publisher"],
    initialReview: json["initial_review"],
    imageS: json["image_s"],
    imageM: json["image_m"],
    imageL: json["image_l"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "author": author,
    "isbn": isbn,
    "year": year,
    "publisher": publisher,
    "initial_review": initialReview,
    "image_s": imageS,
    "image_m": imageM,
    "image_l": imageL,
    "user": user,
  };
}
