import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:librarium_mob/models/request_model.dart';

Future<List<BookRequest>> fetchRequest(request) async {

  List<BookRequest> requestList = [];

  var url = Uri.parse('https://librarium-c01-tk.pbp.cs.ui.ac.id/book-request/json/');
  var response = await request.get('https://librarium-c01-tk.pbp.cs.ui.ac.id/book-request/json/');

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