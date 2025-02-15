import 'message.dart';

class MessagesData {
  List<Message>? messages;
  int? notificationNotSeenCount;

  MessagesData({
    this.messages,
    this.notificationNotSeenCount,
  });

  MessagesData.fromJson(Map<String, dynamic> json) {
    if (json['notification'] != null) {
      messages = [];
      json['notification'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
    notificationNotSeenCount = json["notification_not_seen_count"];
  }
}