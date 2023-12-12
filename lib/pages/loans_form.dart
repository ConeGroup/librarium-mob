import 'dart:convert';
import 'package:flutter/material.dart';
// Impor drawer yang sudah dibuat sebelumnya
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:librarium_mob/models/loans_model.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:librarium_mob/pages/loans_page.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:librarium_mob/apptheme.dart';

List<LoansBook> loansList = [];

class LoansFormPage extends StatefulWidget {
  const LoansFormPage({super.key});

  @override
  State<LoansFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<LoansFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _number = 0;
  DateTime _dateReturn = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form to Add Your Loan Books',
          ),
        ),
        backgroundColor: AppTheme.defaultBlue,
        foregroundColor: Colors.white,
      ),
      // Tambahkan drawer yang sudah dibuat di sini
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                // Tambahkan variabel yang sesuai (_price)
                onChanged: (String? value) {
                  setState(() {
                    _number = int.parse(value!);
                  });
                },
                validator: (String? value) {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Date Return: ${_dateReturn.toLocal()}'),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _dateReturn,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 10)),
                      );

                      if (pickedDate != null && pickedDate != _dateReturn) {
                        setState(() {
                          _dateReturn = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.defaultBlue,),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Kirim ke Django dan tunggu respons
                      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!

                      final formatter = DateFormat('yyyy-MM-dd');
                      final response = await request.postJson(
                          "http://127.0.0.1:8000/show_loans/create-loans-flutter/",
                          jsonEncode(<String, String>{
                            //'user': request.
                            'number_book': _number.toString(),
                            'date_loan':
                                formatter.format(DateTime.now().toLocal()),
                            'date_return':
                                formatter.format(_dateReturn.toLocal()),
                            // TODO: Sesuaikan field data sesuai dengan aplikasimu
                          }));
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Produk baru berhasil disimpan!"),
                        ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoansPage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                        ));
                      }
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
