import 'package:bookhavenapp/screens/review.dart';
import 'package:bookhavenapp/widgets/ratingindicator.dart';
import 'package:bookhavenapp/widgets/reviewcard.dart';
import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  const Ratings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookDetails()));
            },
          ),
          title: Text(
            "Ratings & Reviews",
            style: TextStyle(
              fontSize: 30,
              color: Color(0xFF110239),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ratings and reviews are verified and are from people who use the same type of device you use.",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF110239),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                TOverallProductRating(),
                TRatingBarIndicator(rating: 4.5,),
                Text(
                  "560",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF110239),
                  ),
                ),
                SizedBox(height: 50),

                // review user
                UserReview()
              ],
            ),
          ),
        ));
  }
}


class TOverallProductRating extends StatelessWidget {
  const TOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "4.5",
            style: TextStyle(
                fontSize: 90,
                color: Color(0xFF110239),
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              TRatingProgressIndicator(text: '5', value: 1.0),
              TRatingProgressIndicator(text: '4', value: 0.8),
              TRatingProgressIndicator(text: '3', value: 0.6),
              TRatingProgressIndicator(text: '2', value: 0.4),
              TRatingProgressIndicator(text: '1', value: 0.2),
            ],
          ),
        )
      ],
    );
  }
}

class TRatingProgressIndicator extends StatelessWidget {
  const TRatingProgressIndicator(
      {super.key, required this.text, required this.value});

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF110239),
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: 10,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: Color.fromARGB(255, 153, 153, 153),
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD700)),
            ),
          ),
        )
      ],
    );
  }
}
