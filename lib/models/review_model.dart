// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';
import 'package:librarium_mob/models/book_model.dart';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    String model;
    int pk;
    Fields fields;

    Review({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
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
    int user;
    int bookId;
    DateTime dateAdded;
    double rating;
    String bookReviewDesc;
    bool isRecommended;

    Fields({
        required this.user,
        required this.bookId,
        required this.dateAdded,
        required this.rating,
        required this.bookReviewDesc,
        required this.isRecommended,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        bookId: json["book"],
        dateAdded: DateTime.parse(json["date_added"]),
        rating: json["rating"],
        bookReviewDesc: json["book_review_desc"],
        isRecommended: json["is_recommended"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": bookId,
        "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "rating": rating,
        "book_review_desc": bookReviewDesc,
        "is_recommended": isRecommended,
    };
}


