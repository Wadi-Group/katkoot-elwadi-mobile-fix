import 'package:hive/hive.dart';

part 'hatching_hen.g.dart'; // Required for Hive code generation

@HiveType(typeId: 12) // Ensure a unique typeId across models
class HatchingHen extends HiveObject {
  @HiveField(0)
  String? unit;

  @HiveField(1)
  String? title;

  @HiveField(2)
  int? minValue;

  @HiveField(3)
  int? maxValue;

  @HiveField(4)
  int? value;

  @HiveField(5)
  int? step;

  HatchingHen(
      {this.unit,
      this.value,
      this.maxValue,
      this.minValue,
      this.step,
      this.title});

  factory HatchingHen.fromJson(Map<String, dynamic> json) {
    return HatchingHen(
      unit: json['unit'],
      title: json['name'],
      minValue: json["min-value"],
      maxValue: json["max-value"],
      value: json["value"],
      step: json["step"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "unit": unit,
      "name": title,
      "min-value": minValue,
      "max-value": maxValue,
      "value": value,
      "step": step,
    };
  }
}
