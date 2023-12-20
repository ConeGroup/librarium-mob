import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:librarium_mob/models/collections_model.dart';
// import 'package:librarium_mob/models/review_model.dart';
import 'package:librarium_mob/pages/collections/collections_list_page.dart';
// import 'package:librarium_mob/pages/reviews/review_form.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:librarium_mob/pages/loans_catalog_pages.dart';


class AddBooksToCollectionPage extends StatefulWidget {
  final CollectionItemModel collection;

  const AddBooksToCollectionPage({
    Key? key,
    required this.collection,
  }) : super(key: key);

  @override
  State<AddBooksToCollectionPage> createState() => _AddBooksToCollectionPageState();
}

class _AddBooksToCollectionPageState extends State<AddBooksToCollectionPage>{
  final _formKey = GlobalKey<FormState>();
  int _numberBook = 0;
  // int _numberCollection = collection.;

  @override
  Widget build(BuildContext context){
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Books to Collection',
          ),
        ),
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Book Numbers",
                  labelText: "Book Numbers",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value){
                  setState(() {
                    _numberBook = int.parse(value!);
                  });
                },
                validator: (String? value){
                  if (value == null || value.isEmpty) {
                    return "Book Numbers tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Book Numbers harus berupa angka!";
                  }
                  if (int.parse(value) < 1 || int.parse(value) > 100) {
                    return 'Book Numbers harus berupa angka antara 1 dan 100!';
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppTheme.defaultBlue),
                  ),
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                        'https://fazle-ilahi-c01librarium.stndar.dev/collection/add-book-to-collection-flutter/',
                        jsonEncode(<String, dynamic>{
                          'collection_id': widget.collection.pk,
                          'book_id': _numberBook,
                      }));
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text('Books added to collection!'),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CollectionListPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text('There is an error, please try again.'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
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



