class NotificationModel {
  final String id;
  final String message;

  NotificationModel({
    required this.id,
    required this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['_id']?.toString() ?? '',
        message: json['message'] ?? '',  
    );
  }
}