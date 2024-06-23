class RatingBookModel {
  final int id;
  final int userId;
  final int bookId;
  final int rating;
  final String review;

  RatingBookModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.rating,
    required this.review,
  });

  factory RatingBookModel.fromJson(Map<String, dynamic> json) {
    return RatingBookModel(
      id: json['id'],
      userId: json['user_id'],
      bookId: json['book_id'],
      rating: json['rating'],
      review: json['review'],
    );
  }
}
