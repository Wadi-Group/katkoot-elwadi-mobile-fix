import 'package:hive/hive.dart';

part 'measurement_data.g.dart';

@HiveType(typeId: 27) // Unique Hive type ID
class MeasurementData extends HiveObject {
  @HiveField(0)
  String? unit;

  @HiveField(1)
  double? value;

  @HiveField(2)
  double? standard;

  MeasurementData({this.unit, this.value, this.standard});

  factory MeasurementData.fromJson(Map<String, dynamic> json) {
    return MeasurementData(
      unit: json['unit'],
      value: (json["value"] is int) ? json["value"].toDouble() : json["value"],
      standard: (json["standard"] is int)
          ? json["standard"].toDouble()
          : json["standard"],
    );
  }
}
