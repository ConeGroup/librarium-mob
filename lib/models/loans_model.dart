// To parse this JSON data, do
//
//     final loansBook = loansBookFromJson(jsonString);

import 'dart:convert';

List<LoansBook> loansBookFromJson(String str) => List<LoansBook>.from(json.decode(str).map((x) => LoansBook.fromJson(x)));

String loansBookToJson(List<LoansBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoansBook {
    String model;
    int pk;
    Fields fields;

    LoansBook({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory LoansBook.fromJson(Map<String, dynamic> json) => LoansBook(
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
    int numberBook;
    DateTime dateLoan;
    DateTime dateReturn;

    Fields({
        required this.user,
        required this.numberBook,
        required this.dateLoan,
        required this.dateReturn,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        numberBook: json["number_book"],
        dateLoan: DateTime.parse(json["date_loan"]),
        dateReturn: DateTime.parse(json["date_return"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "number_book": numberBook,
        "date_loan": "${dateLoan.year.toString().padLeft(4, '0')}-${dateLoan.month.toString().padLeft(2, '0')}-${dateLoan.day.toString().padLeft(2, '0')}",
        "date_return": "${dateReturn.year.toString().padLeft(4, '0')}-${dateReturn.month.toString().padLeft(2, '0')}-${dateReturn.day.toString().padLeft(2, '0')}",
    };
}
