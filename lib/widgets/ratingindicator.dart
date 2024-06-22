import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key, required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 30,
      unratedColor: Color.fromARGB(255, 153, 153, 153),
      itemBuilder: (_, __) => Icon(Icons.star, color: Color(0xFFFFD700)),
    );
  }
}