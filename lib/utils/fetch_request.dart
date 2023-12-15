import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:librarium_mob/models/request_model.dart';

Future<List<BookRequest>> fetchRequest(request) async {

  List<BookRequest> requestList = [];

  var url = Uri.parse('http://127.0.0.1:8000/book-request/json/');
  var response = await request.get('http://127.0.0.1:8000/book-request/json/');

  // // melakukan decode response menjadi bentuk json
  // var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Product
  for (var d in response) {
    if (d != null) {
      requestList.add(BookRequest.fromJson(d));
    }
  }
  return requestList;
}