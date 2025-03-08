import 'package:hive/hive.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data_value_params.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_preview_data.dart';

part 'week_data_value.g.dart'; // Ensure this file is generated

@HiveType(typeId: 24) // Unique typeId for Hive
class Value extends HiveObject {
  @HiveField(0)
  Params? params;

  @HiveField(1)
  PreviewData? previewData;

  Value({this.params, this.previewData});

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      params: json['params'] == null ? null : Params.fromJson(json['params']),
      previewData: json['preview_data'] == null
          ? null
          : PreviewData.fromJson(json['preview_data']),
    );
  }
}
