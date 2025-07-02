class Message {
  final String senderId;
  final String receiverId;
  final String senderType;
  final String receiverType;
  final String content;
  final String timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.senderType,
    required this.receiverType,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      senderType: json['senderType'],
      receiverType: json['receiverType'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'senderType': senderType,
      'receiverType': receiverType,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
