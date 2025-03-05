import 'package:hive/hive.dart';

part 'fcr.g.dart'; // Required for Hive code generation

@HiveType(typeId: 6) // Ensure a unique typeId across models
class Fcr extends HiveObject {
  @HiveField(0)
  String? fcr;

  Fcr({this.fcr});

  factory Fcr.fromJson(Map<String, dynamic> json) {
    return Fcr(fcr: json["fcr"]);
  }

  Map<String, dynamic> toJson() {
    return {"fcr": fcr};
  }
}
