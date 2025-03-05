import 'package:hive/hive.dart';

part 'pullet_livability_to_cap.g.dart'; // Required for Hive code generation

@HiveType(typeId: 9) // Ensure a unique typeId across models
class PulletLivabilityToCap extends HiveObject {
  @HiveField(0)
  String? unit;

  @HiveField(1)
  String? title;

  @HiveField(2)
  int? minValue;

  @HiveField(3)
  int? maxValue;

  @HiveField(4)
  int? defaultValue;

  @HiveField(5)
  int? step;

  PulletLivabilityToCap(
      {this.unit,
      this.defaultValue,
      this.maxValue,
      this.minValue,
      this.step,
      this.title});

  factory PulletLivabilityToCap.fromJson(Map<String, dynamic> json) {
    return PulletLivabilityToCap(
      unit: json['unit'],
      title: json['name'],
      minValue: json["min-value"],
      maxValue: json["max-value"],
      step: json["step"],
      defaultValue: json["default-value"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "unit": unit,
      "name": title,
      "min-value": minValue,
      "max-value": maxValue,
      "step": step,
      "default-value": defaultValue,
    };
  }
}
