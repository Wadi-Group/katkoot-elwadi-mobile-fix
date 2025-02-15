
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data_value_params.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_preview_data.dart';

class Value {
  Params? params;
  PreviewData? previewData;

  Value({this.params,this.previewData});

  Value.fromJson(Map<String, dynamic> json) {
    params = json['params'] == null
        ? null
        : Params.fromJson(json['params']);
    previewData = json['preview_data'] == null
        ? null
        : PreviewData.fromJson(json['preview_data']);
  }

}
