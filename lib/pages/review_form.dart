import 'package:flutter/material.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya

class ReviewFormPage extends StatefulWidget {
    const ReviewFormPage({super.key});

    @override
    State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _bookTitle = "";
    int _rating = 0;
    String _description = "";

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Form Tambah Review',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          // TODO: Tambahkan drawer yang sudah dibuat di sini
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Nama Produk",
                          labelText: "Nama Produk",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _bookTitle = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Book Title tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),
              )
            ]
              
            ),
          ),
          )
        );

    }
}