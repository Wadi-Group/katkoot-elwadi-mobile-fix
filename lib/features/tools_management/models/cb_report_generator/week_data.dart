
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/week_data_value.dart';

class CbWeekData {
  int? id;
  int? duration;
  Value? value;

  CbWeekData({
    this.id,
    this.duration,
    this.value,
  });

  CbWeekData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    value = json['value'] == null
        ? null
        : Value.fromJson(json['value']);
  }

}
