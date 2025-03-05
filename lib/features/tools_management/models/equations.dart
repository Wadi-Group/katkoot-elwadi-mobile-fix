import 'package:hive/hive.dart';
import 'broiler.dart';
import 'pullet.dart';
import 'fcr.dart';
import 'pef.dart';

part 'equations.g.dart'; // Required for Hive code generation

@HiveType(typeId: 3) // Ensure this is unique across models
class Equations extends HiveObject {
  @HiveField(0)
  Broiler? broiler;

  @HiveField(1)
  Pullet? pullet;

  @HiveField(2)
  Fcr? fcr;

  @HiveField(3)
  Pef? pef;

  Equations({this.broiler, this.pullet, this.fcr, this.pef});

  factory Equations.fromJson(Map<String, dynamic> json) {
    return Equations(
      broiler: json['broiler'] == null
          ? null
          : Broiler.fromJson(Map<String, dynamic>.from(json["broiler"])),
      pullet: json['pullet'] == null
          ? null
          : Pullet.fromJson(Map<String, dynamic>.from(json["pullet"])),
      fcr: json['fcr'] == null
          ? null
          : Fcr.fromJson(Map<String, dynamic>.from(json["fcr"])),
      pef: json['pef'] == null
          ? null
          : Pef.fromJson(Map<String, dynamic>.from(json["pef"])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'broiler': broiler?.toJson(),
      'pullet': pullet?.toJson(),
      'fcr': fcr?.toJson(),
      'pef': pef?.toJson(),
    };
  }
}
