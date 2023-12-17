// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/models/collections_model.dart';
import 'package:librarium_mob/pages/collections/collections_page.dart';
import 'package:librarium_mob/pages/register_page.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:librarium_mob/models/book_model.dart' as book_model;
import 'package:librarium_mob/models/collections_model.dart' as collections_model;


class CollectionFormPage extends StatefulWidget {

  const CollectionFormPage({super.key});

  @override
  State<CollectionFormPage> createState() => _CollectionFormPageState();
}

class _CollectionFormPageState extends State<CollectionFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _nameCollection = '';
  List<book_model.Book> _books = [];
  List<collections_model.CollectionItem> _collections = [];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Collection'),
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Collection Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _nameCollection = value!;
                  });
                },
                validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Book description cannot be empty!";
                    }
                    return null;
                  },
              ),
              // Di sini tambahkan bagian untuk menambahkan buku ke dalam koleksi
              // Misalnya, menggunakan TextFormField atau DropdownButtonFormField
              // sesuai dengan kebutuhan Anda
              // Pastikan untuk menambahkan logika untuk menambahkan buku ke dalam list _books
              // serta menampilkan koleksi yang sudah dipilih
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppTheme.defaultBlue),
                    ),
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                        'http://127.0.0.1:8000/collection/create-collection-flutter/',
                        jsonEncode(<String, dynamic>{
                          'name': _nameCollection.toString(),
                        }));
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Collection added successfully!')));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CollectionsPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('There is an error, please try again.')));
                      }
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




  //Lanjutkan Metode Ini untuk membuat list collection dan nantinya list collection tersebut akan dapat diisi buku
