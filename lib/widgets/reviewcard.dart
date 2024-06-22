import 'package:bookhavenapp/widgets/ratingindicator.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReview extends StatelessWidget {
  const UserReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildUserReview(
          context,
          profileImage: 'assets/images/profile.jpg',
          userName: 'John Doe',
          rating: 4.5,
          reviewDate: '22 Nov, 2024',
          reviewText: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        ),
        const SizedBox(height: 40),


        buildUserReview(
          context,
          profileImage: 'assets/images/profile.jpg',
          userName: 'Jane Smith',
          rating: 4.0,
          reviewDate: '20 Nov, 2024',
          reviewText: 'Second review text goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        ),
      ],
    );
  }

  Widget buildUserReview(
    BuildContext context, {
    required String profileImage,
    required String userName,
    required double rating,
    required String reviewDate,
    required String reviewText,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(profileImage),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Color(0xFF110239),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(width: 20),

        // review
        Row(
          children: [
            TRatingBarIndicator(rating: rating),
            const SizedBox(width: 20),
            Text(
              reviewDate,
              style: TextStyle(
                  fontSize: 20,
                  color: const Color(0xFF110239).withOpacity(0.5),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ReadMoreText(
          reviewText,
          trimLines: 2,
          trimMode: TrimMode.Line,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          lessStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
