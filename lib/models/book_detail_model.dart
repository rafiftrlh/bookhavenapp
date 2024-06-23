class BookDetail {
  final int id;
  final String bookCode;
  final String? coverUrl;
  final String titleBook;
  final String synopsis;
  final String language;
  final int stock;
  final int price;

  BookDetail({
    required this.id,
    required this.bookCode,
    this.coverUrl,
    required this.titleBook,
    required this.synopsis,
    required this.language,
    required this.stock,
    required this.price,
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
    );
  }
}
