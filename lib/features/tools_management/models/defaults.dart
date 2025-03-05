import 'package:hive/hive.dart';
import 'broiler_per_week.dart';
import 'broiler_livability.dart';
import 'hatch.dart';
import 'hatching_hen.dart';
import 'pullet_livability_to_cap.dart';
import 'pullets.dart';

part 'defaults.g.dart'; // Required for Hive code generation

@HiveType(typeId: 8) // Ensure a unique typeId across models
class Defaults extends HiveObject {
  @HiveField(0)
  double? feedWeight;

  @HiveField(1)
  PulletLivabilityToCap? pulletLivabilityToCap;

  @HiveField(2)
  BroilerPerWeek? broilerPerWeek;

  @HiveField(3)
  Pullets? pullets;

  @HiveField(4)
  HatchingHen? hatchedHen;

  @HiveField(5)
  Hatch? hatch;

  @HiveField(6)
  BroilerLivability? broilerLivability;

  Defaults(
      {this.feedWeight,
      this.broilerLivability,
      this.broilerPerWeek,
      this.pullets,
      this.hatch,
      this.hatchedHen,
      this.pulletLivabilityToCap});

  factory Defaults.fromJson(Map<String, dynamic> json) {
    return Defaults(
      feedWeight: json["feed_weight"],
      pulletLivabilityToCap: json['pullet_livability_to_cap'] == null
          ? null
          : PulletLivabilityToCap.fromJson(
              Map<String, dynamic>.from(json["pullet_livability_to_cap"])),
      hatchedHen: json['hatching_hen'] == null
          ? null
          : HatchingHen.fromJson(
              Map<String, dynamic>.from(json['hatching_hen'])),
      broilerPerWeek: json['broiler_per_week'] == null
          ? null
          : BroilerPerWeek.fromJson(
              Map<String, dynamic>.from(json['broiler_per_week'])),
      pullets: json['pullets'] == null
          ? null
          : Pullets.fromJson(Map<String, dynamic>.from(json['pullets'])),
      hatch: json['hatch'] == null
          ? null
          : Hatch.fromJson(Map<String, dynamic>.from(json["hatch"])),
      broilerLivability: json['broiler_livability'] == null
          ? null
          : BroilerLivability.fromJson(
              Map<String, dynamic>.from(json["broiler_livability"])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "feed_weight": feedWeight,
      "pullet_livability_to_cap": pulletLivabilityToCap?.toJson(),
      "broiler_per_week": broilerPerWeek?.toJson(),
      "pullets": pullets?.toJson(),
      "hatching_hen": hatchedHen?.toJson(),
      "hatch": hatch?.toJson(),
      "broiler_livability": broilerLivability?.toJson(),
    };
  }
}
