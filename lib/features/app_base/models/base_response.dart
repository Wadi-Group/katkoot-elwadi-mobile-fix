import 'package:katkoot_elwady/features/menu_management/models/contact_us_model.dart';
import 'package:katkoot_elwady/features/menu_management/models/where_to_find_us_data.dart';
import 'package:katkoot_elwady/features/messages_management/models/messages_data.dart';
import 'package:katkoot_elwady/features/messages_management/models/read_message_data.dart';
import 'package:katkoot_elwady/features/messages_management/models/send_message_success_data.dart';
import 'package:katkoot_elwady/features/search_management/models/search_model.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/cycle.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data.dart';
import 'package:katkoot_elwady/features/user_management/models/phone_exist.dart';
import 'package:katkoot_elwady/features/user_management/models/unseen_notification_count_data.dart';
import 'package:katkoot_elwady/features/user_management/models/user.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';

class BaseResponse<T> {
  final T? data;
  final String? message;
  final Map<String, dynamic>? errors;
  final bool? status;

  BaseResponse({this.data, this.message, this.errors, this.status});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? errors;
    if (json['errors'] != null) {
      errors = json['errors'];
    } else if (json['error'] != null) {
      errors = json['error'];
    }
    return BaseResponse(
        data: json["data"] == null ? null : _dataFromJson<T>(json),
        message:
            json is List ? null : json["message"] ?? json["data"]['message'],
        errors: errors,
        status: json["status"]);
  }

  static T? _dataFromJson<T>(dynamic json) {
    if (T == User) {
      return User.fromJson(json['data']) as T;
    } else if (T == UserData) {
      return UserData.fromJson(json['data']) as T;
    } else if (T == Tool) {
      return Tool.fromJson(json['data']) as T;
    } else if (T == PhoneExistence) {
      return PhoneExistence.fromJson(json['data']) as T;
    } else if (T == List) {
      return json['data'] as T;
    } else if (T == ContactUsData) {
      return ContactUsData.fromJson(json["data"]) as T;
    } else if (T == WeekData) {
      return WeekData.fromJson(json["data"]) as T;
    } else if (T == Cycle) {
      return Cycle.fromJson(json["data"]) as T;
    } else if (T == ReadMessageData) {
      return ReadMessageData.fromJson(json["data"]) as T;
    } else if (T == SendMessageSuccessData) {
      return SendMessageSuccessData.fromJson(json["data"]) as T;
    } else if (T == WhereToFindUsData) {
      return WhereToFindUsData.fromJson(json["data"]) as T;
    } else if (T == MessagesData) {
      return MessagesData.fromJson(json["data"]) as T;
    } else if (T == UnseenNotificationCountData) {
      return UnseenNotificationCountData.fromJson(json["data"]) as T;
    } else if (T == SearchModel) {
      if (json["data"] is List) {
        return SearchModel.fromJson({}) as T;
      }
      return SearchModel.fromJson(json["data"]) as T;
    } else {
      return null;
    }
  }
}
