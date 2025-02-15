class ReadMessageData {
  String? message;
  int? notificationNotSeenCount;

  ReadMessageData({
    this.message,
    this.notificationNotSeenCount,
  });

  factory ReadMessageData.fromJson(Map<String, dynamic> json) {
    return ReadMessageData(
      message: json['message'],
      notificationNotSeenCount: json["notification_not_seen_count"]
    );
  }
}
