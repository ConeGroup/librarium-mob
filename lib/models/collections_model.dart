// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<CollectionItemModel> welcomeFromJson(String str) => List<CollectionItemModel>.from(json.decode(str).map((x) => CollectionItemModel.fromJson(x)));

String welcomeToJson(List<CollectionItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollectionItemModel {
    String model;
    int pk;
    Fields fields;

    CollectionItemModel({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory CollectionItemModel.fromJson(Map<String, dynamic> json) => CollectionItemModel(
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
    String name;
    List<int> books;

    Fields({
        required this.user,
        required this.name,
        required this.books,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        books: List<int>.from(json["books"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "books": List<dynamic>.from(books.map((x) => x)),
    };
}