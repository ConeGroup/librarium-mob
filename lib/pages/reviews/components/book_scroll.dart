import 'package:flutter/material.dart';
import 'package:librarium_mob/pages/reviews/eachbook_review.dart';
import 'package:librarium_mob/pages/reviews/review_page.dart';
import 'package:librarium_mob/utils/fetch_reviews.dart';

import 'section_title.dart';

class PopularBooks extends StatelessWidget {
  const PopularBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SectionTitle(
            title: "Popular books lately",
            press: () {
              Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ReviewPage()));
            },
          ),
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              PopularBookCard(
                image: "https://m.media-amazon.com/images/P/0446310786.01.LZZZZZZZ.jpg",
                title: "To Kill a Mockingbird",
                author: "Harper Lee",
                bookId: 38,
              ),
              PopularBookCard(
                image: "https://m.media-amazon.com/images/P/0441783589.01.LZZZZZZZ.jpg",
                title: "Starship Troopers",
                author: "Robert A. Heinlein",
                bookId: 78,
              ),
              PopularBookCard(
                image: "https://m.media-amazon.com/images/P/0316769487.01.LZZZZZZZ.jpg",
                title: "The Catcher in the Rye",
                author: "J.D. Salinger",
                bookId: 91,
              ),
              PopularBookCard(
                image: "https://m.media-amazon.com/images/P/0440234743.01.LZZZZZZZ.jpg",
                title: "The Testament",
                author: "John Grisham",
                bookId: 19,
              ),
              PopularBookCard(
                image: "https://m.media-amazon.com/images/P/1552041778.01.LZZZZZZZ.jpg",
                title: "Jane Doe",
                author: "R. J. Kaiser",
                bookId: 14,
              ),
              SizedBox(width: 20, height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class PopularBookCard extends StatelessWidget {
  const PopularBookCard({
    super.key,
    required this.title,
    required this.image,
    required this.author,
    required this.bookId,
  });

  final String title;
  final String image;
  final String author;
  final int bookId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: (){
            fetchBookById(bookId).then((book) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookPage(book: book)));
          });
        },        
        child: SizedBox(
          width: 160,
          height: 240,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black12,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$title\n",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "by $author")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
