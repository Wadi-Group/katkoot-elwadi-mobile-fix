import 'package:hive/hive.dart';
import 'package:katkoot_elwady/features/tools_management/models/report_generator/week_data_value.dart';

part 'week_data.g.dart'; // Ensure this part directive is present

@HiveType(typeId: 22) // Unique typeId for Hive
class WeekData extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? duration;

  @HiveField(2)
  Value? value;

  WeekData({
    this.id,
    this.duration,
    this.value,
  });

  WeekData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    value = json['value'] == null ? null : Value.fromJson(json['value']);
  }
}
