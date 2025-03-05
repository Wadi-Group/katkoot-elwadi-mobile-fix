import 'package:hive/hive.dart';

part 'pullets.g.dart'; // Required for Hive code generation

@HiveType(typeId: 11) // Ensure a unique typeId across models
class Pullets extends HiveObject {
  @HiveField(0)
  String? unit;

  @HiveField(1)
  int? minValue;

  @HiveField(2)
  int? maxValue;

  @HiveField(3)
  int? defaultValue;

  Pullets({this.unit, this.defaultValue, this.maxValue, this.minValue});

  factory Pullets.fromJson(Map<String, dynamic> json) {
    return Pullets(
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
