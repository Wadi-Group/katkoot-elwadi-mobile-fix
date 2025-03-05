import 'package:hive/hive.dart';

part 'pullet.g.dart'; // Required for Hive code generation

@HiveType(typeId: 5) // Ensure a unique typeId across models
class Pullet extends HiveObject {
  @HiveField(0)
  String? broilersPerYear;

  @HiveField(1)
  String? placedEggs;

  @HiveField(2)
  String? hatchingEggs;

  @HiveField(3)
  String? hen;

  @HiveField(4)
  String? broilersPerWeek;

  Pullet({
    this.broilersPerYear,
    this.hen,
    this.placedEggs,
    this.broilersPerWeek,
    this.hatchingEggs,
  });

  factory Pullet.fromJson(Map<String, dynamic> json) {
    return Pullet(
      broilersPerYear: json["broilers_per_year"],
      placedEggs: json["placed_eggs"],
      hatchingEggs: json["hatching_egg"],
      hen: json["hen"],
      broilersPerWeek: json["broilers_per_week"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "broilers_per_year": broilersPerYear,
      "placed_eggs": placedEggs,
      "hatching_egg": hatchingEggs,
      "hen": hen,
      "broilers_per_week": broilersPerWeek,
    };
  }
}
