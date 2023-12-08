// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });


    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String isbn;
    String title;
    String author;
    int year;
    String publisher;
    String imageS;
    String imageM;
    String imageL;

    Fields({
        required this.isbn,
        required this.title,
        required this.author,
        required this.year,
        required this.publisher,
        required this.imageS,
        required this.imageM,
        required this.imageL,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["ISBN"],
        title: json["title"],
        author: json["author"],
        year: json["year"],
        publisher: json["publisher"],
        imageS: json["image_s"],
        imageM: json["image_m"],
        imageL: json["image_l"],
    );

    Map<String, dynamic> toJson() => {
        "ISBN": isbn,
        "title": title,
        "author": author,
        "year": year,
        "publisher": publisher,
        "image_s": imageS,
        "image_m": imageM,
        "image_l": imageL,
    };
}

enum Model {
    BOOK_BOOK
}

final modelValues = EnumValues({
    "book.book": Model.BOOK_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
