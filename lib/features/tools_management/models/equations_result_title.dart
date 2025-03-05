import 'package:hive/hive.dart';

part 'equations_result_title.g.dart'; // Required for Hive code generation

@HiveType(typeId: 15) // Ensure a unique typeId across models
class EquationsResultTitle extends HiveObject {
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

  @HiveField(5)
  String? chickenPlacedBeforeDeath;

  @HiveField(6)
  String? pullets;

  EquationsResultTitle({
    this.broilersPerYear,
    this.placedEggs,
    this.hatchingEggs,
    this.hen,
    this.broilersPerWeek,
    this.chickenPlacedBeforeDeath,
    this.pullets,
  });

  factory EquationsResultTitle.fromJson(Map<String, dynamic> json) {
    return EquationsResultTitle(
      broilersPerYear: json["broilers_per_year"],
      placedEggs: json["placed_eggs"],
      hatchingEggs: json["hatching_egg"],
      hen: json["hen"],
      chickenPlacedBeforeDeath: json["chicken_placed_before_death"],
      pullets: json["pullets"],
      broilersPerWeek: json["broilers_per_week"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "broilers_per_year": broilersPerYear,
      "placed_eggs": placedEggs,
      "hatching_egg": hatchingEggs,
      "hen": hen,
      "chicken_placed_before_death": chickenPlacedBeforeDeath,
      "pullets": pullets,
      "broilers_per_week": broilersPerWeek,
    };
  }
}
