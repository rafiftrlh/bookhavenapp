import 'package:bookhavenapp/models/author_model.dart';
import 'package:bookhavenapp/models/category_model.dart';

class BookDetail {
  final int id;
  final String bookCode;
  final String? coverUrl;
  final String titleBook;
  final String synopsis;
  final String language;
  final int stock;
  final int price;
  final List<Author> authors;
  final List<CategoryModel> categories;
  final double total_rating;

  BookDetail({
    required this.id,
    required this.bookCode,
    this.coverUrl,
    required this.titleBook,
    required this.synopsis,
    required this.language,
    required this.stock,
    required this.price,
    required this.authors,
    required this.categories,
    required this.total_rating,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) {
    return BookDetail(
      id: json['id'],
      bookCode: json['book_code'],
      coverUrl: json['cover_url'],
      titleBook: json['title_book'],
      synopsis: json['synopsis'],
      language: json['language'],
      stock: json['stock'],
      price: json['price'],
      authors: (json['authors'] as List<dynamic>?)
          ?.map((authorJson) => Author.fromJson(authorJson))
          .toList() ?? [],
      categories: (json['categories'] as List<dynamic>?)
          ?.map((authorJson) => CategoryModel.fromJson(authorJson))
          .toList() ?? [],
      total_rating: json['total_rating'],
    );
  }
}
