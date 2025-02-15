import 'package:katkoot_elwady/features/app_base/models/items_response.dart';

class BaseListResponse<T> {
  final ItemsResponse<T>? data;
  final String? message;
  final Map<String, dynamic>? errors;

  BaseListResponse({this.data, this.message, this.errors});

  factory BaseListResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? errors;
    if (json['errors'] != null) {
      errors = json['errors'];
    }
    return BaseListResponse(
      data: json["data"] == null
          ? null
          : _dataFromJson<T>(json) as ItemsResponse<T>?,
      message: json["message"] == null ? null : json["message"],
      errors: errors,
    );
  }

  static ItemsResponse? _dataFromJson<T>(dynamic json) {
    print(json);
    return ItemsResponse<T>.fromDynamic(json['data']);
  }
}
