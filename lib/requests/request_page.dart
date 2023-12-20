import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/models/request_model.dart';
import 'package:librarium_mob/widgets/request_widget/floating_button_request.dart';
import 'package:librarium_mob/widgets/request_widget/list_request.dart';
import 'package:librarium_mob/pages/menu.dart';
import 'package:librarium_mob/widgets/request_widget/request_page_header.dart';
import 'package:librarium_mob/utils/request_utils/fetch_request.dart';
import 'package:librarium_mob/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  late Future<List<BookRequest>> _request;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    _request = fetchRequest(request);

    return Scaffold(
      appBar: const AppBarBuild(),
      drawer: const LeftDrawer(),
      bottomNavigationBar: const BottomNavBarFb1(),
      floatingActionButton: const FloatingAddRequestBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: FutureBuilder<List<BookRequest>>(
        future: _request,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BookRequestHeader(),
                  const Center(
                    child: Text(
                      "You haven't request any book yet",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            );
          } else {
            return ListView(
              children: [
                BookRequestHeader(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var myRequest = snapshot.data![index];
                    return RequestListItem(
                      bookRequest: myRequest,
                      request: request,
                    );
                  },
                ),
                const SizedBox(height: 70)
              ],
            );
          }
        },
      ),
    );
  }
}
