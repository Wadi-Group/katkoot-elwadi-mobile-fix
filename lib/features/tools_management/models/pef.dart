import 'package:hive/hive.dart';

part 'pef.g.dart'; // Required for Hive code generation

@HiveType(typeId: 7) // Ensure a unique typeId across models
class Pef extends HiveObject {
  @HiveField(0)
  String? pef;

  Pef({this.pef});

  factory Pef.fromJson(Map<String, dynamic> json) {
    return Pef(pef: json["pef"]);
  }

  Map<String, dynamic> toJson() {
    return {"pef": pef};
  }
}
