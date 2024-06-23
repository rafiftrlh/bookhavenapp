class BorrowingModel {
  final int id;
  final int userId;
  final int bookId;
  final String borrowDate;
  final String returnDate;
  final String dueDate;
  final String status;
  final int? approvedBy;
  final String? permissionDate;

  BorrowingModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.returnDate,
    required this.dueDate,
    required this.status,
    this.approvedBy,
    this.permissionDate,
  });

  factory BorrowingModel.fromJson(Map<String, dynamic> json) {
    return BorrowingModel(
      id: json['id'],
      userId: json['user_id'],
      bookId: json['book_id'],
      borrowDate: json['borrow_date'],
      returnDate: json['return_date'],
      dueDate: json['due_date'],
      status: json['status'],
      approvedBy: json['approved_by'],
      permissionDate: json['permission_date'],
    );
  }
}
