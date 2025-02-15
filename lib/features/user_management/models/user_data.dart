import 'package:katkoot_elwady/features/user_management/models/user.dart';

class UserData {
  User? user;
  String? token;
  int? notificationNotSeenCount;
  String? messgae;


  UserData({this.user, this.token, this.notificationNotSeenCount, this.messgae});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        user: json['user'] == null ? null : User.fromJson(json['user']),
        token: json['token'],
        notificationNotSeenCount: json['notification_not_seen_count'],
        messgae: json["message"]);
  }



  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'token': token,
      'notification_not_seen_count': notificationNotSeenCount
    };
  }
}
