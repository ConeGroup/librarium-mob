// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/pages/collections/collections_list_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CollectionFormPage extends StatefulWidget {

  const CollectionFormPage({super.key});

  @override
  State<CollectionFormPage> createState() => _CollectionFormPageState();
}

class _CollectionFormPageState extends State<CollectionFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _nameCollection = "";



  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Collection'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },


        ),
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: Colors.white,
      ),
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
                            builder: (context) => const CollectionListPage(),
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




