
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librarium_mob/apptheme.dart';
import 'package:librarium_mob/models/book_model.dart';
import 'package:librarium_mob/models/review_model.dart';
import 'package:librarium_mob/pages/reviews/components/floating_button.dart';
import 'package:librarium_mob/utils/fetch_reviews.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class BookPage extends StatefulWidget {
  final Book book;

  const BookPage({super.key, required this.book});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late Book book;
  late Future<List<Review>> _reviews;


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    book = widget.book;
    _reviews = fetchBookReview(request, book.pk);

    return Scaffold(
      floatingActionButton: FloatingThisBookReviewBtn(thisBook: book),
      floatingActionButtonLocation:    
          FloatingActionButtonLocation.endFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              foregroundColor: Colors.white,
              expandedHeight: 300.0,
              backgroundColor: AppTheme.defaultBlue,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  collapseMode: CollapseMode.parallax,
                  
                  title: Text(book.fields.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Color.fromRGBO(0, 0, 0, 0.479),
                            offset: Offset(1, 2),
                          ),
                        ],
                      )
                      
                      ),
                  background: Image.network(
                   book.fields.imageL,
                    fit: BoxFit.cover,
                  )),
                  ),
                ];
              },
  
          body: SingleChildScrollView(
            child:
          Column(
            children: [
            Container(
              width: 160,
              height: 240,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.book.fields.imageL),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    widget.book.fields.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By ${widget.book.fields.author}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
              FutureBuilder<List<Review>>(
                  future: _reviews,
                  builder: (context, AsyncSnapshot<List<Review>> reviewSnapshot) {
                    if (reviewSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (reviewSnapshot.hasError) {
                      return Center(child: Text('Error: ${reviewSnapshot.error}'));
                    } else if (!reviewSnapshot.hasData || reviewSnapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No review yet",
                          style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: reviewSnapshot.data!.length,
                        itemBuilder: (context, index) {
                          var review = reviewSnapshot.data![index];
                          return BookReviewItem(
                            book: book,
                            review: review,
                          );
                        },
                      );
                    }
                  },
                ),

            // ),
        ],),
          ),
      ),
      // ),       
    );
  }
}

String formatDate(DateTime dateTime) {
  String formattedDate =
      DateFormat('EEEE, MMMM d y').format(dateTime);
  return formattedDate;
}


class BookReviewItem extends StatelessWidget {
  final Book book;
  final Review review;

  const BookReviewItem({
    super.key,
    required this.book,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side (book details)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Text(
                        " ${review.fields.rating.toString()}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review.fields.bookReviewDesc,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatDate(review.fields.dateAdded),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),         
        ],
      ),
    );
  }
}