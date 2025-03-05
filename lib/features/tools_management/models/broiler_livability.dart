import 'package:hive/hive.dart';

part 'broiler_livability.g.dart'; // Required for Hive code generation

@HiveType(typeId: 14) // Ensure a unique typeId across models
class BroilerLivability extends HiveObject {
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

  BroilerLivability({
    this.unit,
    this.defaultValue,
    this.maxValue,
    this.minValue,
    this.step,
    this.title,
  });

  factory BroilerLivability.fromJson(Map<String, dynamic> json) {
    return BroilerLivability(
      unit: json['unit'],
      title: json['name'],
      minValue: json["min-value"],
      maxValue: json["max-value"],
      defaultValue: json["default-value"],
      step: json["step"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "unit": unit,
      "name": title,
      "min-value": minValue,
      "max-value": maxValue,
      "default-value": defaultValue,
      "step": step,
    };
  }
}
