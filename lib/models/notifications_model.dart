class NotificationModel {
  final int id;
  final int userId;
  final String message;
  final String status;
  final String notificationType;
  final bool isRead;
      

  NotificationModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.status,
    required this.notificationType,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['user_id'],
      message: json['message'],
      status: json['status'],
      notificationType: json['notification_type'],
      isRead: json['is_read'] ?? false,
    );
  }
}
