import 'package:hive/hive.dart';

part 'slider_data.g.dart'; // Auto-generated file

@HiveType(typeId: 18) // Ensure typeId is unique
class SliderData extends HiveObject {
  @HiveField(0)
  int? minValue;

  @HiveField(1)
  int? maxValue;

  @HiveField(2)
  int? step;

  @HiveField(3)
  int? defaultValue;

  SliderData({this.minValue, this.maxValue, this.step, this.defaultValue});

  SliderData.fromJson(Map<String, dynamic> json) {
    minValue = json['min-value'];
    maxValue = json['max-value'];
    step = json["step"];
    defaultValue = json["default-value"];
  }

  Map<String, dynamic> toJson() {
    return {
      'min-value': minValue,
      'max-value': maxValue,
      'step': step,
      'default-value': defaultValue,
    };
  }
}
