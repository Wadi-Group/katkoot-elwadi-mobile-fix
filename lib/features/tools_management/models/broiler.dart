import 'package:hive/hive.dart';

part 'broiler.g.dart'; // Required for Hive code generation

@HiveType(typeId: 4) // Ensure this is unique across models
class Broiler extends HiveObject {
  @HiveField(0)
  String? broilersPerYear;

  @HiveField(1)
  String? chickenPlacedBeforeDeath;

  @HiveField(2)
  String? placedEggs;

  @HiveField(3)
  String? hen;

  @HiveField(4)
  String? pullets;

  Broiler({
    this.broilersPerYear,
    this.chickenPlacedBeforeDeath,
    this.placedEggs,
    this.hen,
    this.pullets,
  });

  factory Broiler.fromJson(Map<String, dynamic> json) {
    return Broiler(
      broilersPerYear: json["broilers_per_year"],
      chickenPlacedBeforeDeath: json["chicken_placed_before_death"],
      placedEggs: json["placed_eggs"],
      hen: json["hen"],
      pullets: json["pullets"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "broilers_per_year": broilersPerYear,
      "chicken_placed_before_death": chickenPlacedBeforeDeath,
      "placed_eggs": placedEggs,
      "hen": hen,
      "pullets": pullets,
    };
  }
}
