import 'package:hive/hive.dart';

part 'broiler_per_week.g.dart'; // Required for Hive code generation

@HiveType(typeId: 10) // Ensure a unique typeId across models
class BroilerPerWeek extends HiveObject {
  @HiveField(0)
  String? unit;

  @HiveField(1)
  int? minValue;

  @HiveField(2)
  int? maxValue;

  @HiveField(3)
  int? defaultValue;

  BroilerPerWeek({this.unit, this.defaultValue, this.maxValue, this.minValue});

  factory BroilerPerWeek.fromJson(Map<String, dynamic> json) {
    return BroilerPerWeek(
      unit: json['unit'],
      minValue: json["min-value"],
      maxValue: json["max-value"],
      defaultValue: json["default-value"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "unit": unit,
      "min-value": minValue,
      "max-value": maxValue,
      "default-value": defaultValue,
    };
  }
}
