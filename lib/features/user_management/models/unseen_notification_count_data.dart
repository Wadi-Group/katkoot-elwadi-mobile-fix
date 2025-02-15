class UnseenNotificationCountData {
  int? unseenCount;

  UnseenNotificationCountData({
    this.unseenCount,
   });

  factory UnseenNotificationCountData.fromJson(Map<String, dynamic> json) {
    return UnseenNotificationCountData(
      unseenCount: json['notification_not_seen_count'],
    );
  }
}
