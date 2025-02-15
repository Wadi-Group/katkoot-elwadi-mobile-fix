
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data_value.dart';

class WeekData {
  int? id;
  int? duration;
  Value? value;

  WeekData({
    this.id,
    this.duration,
    this.value,
  });

  WeekData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    value = json['value'] == null
        ? null
        : Value.fromJson(json['value']);
  }

}
