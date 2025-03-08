import 'package:hive/hive.dart';
import 'measurement_data.dart';

part 'week_preview_data.g.dart';

@HiveType(typeId: 26) // Unique type ID for PreviewData
class PreviewData extends HiveObject {
  @HiveField(0)
  MeasurementData? cumulativeFemaleMortPercentage;

  @HiveField(1)
  MeasurementData? cumulativeUtilize;

  @HiveField(2)
  MeasurementData? eggMass;

  @HiveField(3)
  MeasurementData? eggWeight;

  @HiveField(4)
  MeasurementData? femaleFeed;

  @HiveField(5)
  MeasurementData? femaleWeight;

  @HiveField(6)
  MeasurementData? hatchedEggPerHatchedHen;

  @HiveField(7)
  MeasurementData? hatchedHenPercentage;

  @HiveField(8)
  MeasurementData? hatchedPercentage;

  @HiveField(9)
  MeasurementData? hatchedWeightPercentage;

  @HiveField(10)
  MeasurementData? lightingProgram;

  @HiveField(11)
  MeasurementData? maleFeed;

  @HiveField(12)
  MeasurementData? maleWeight;

  @HiveField(13)
  MeasurementData? totalEggPerHatchedHen;

  @HiveField(14)
  MeasurementData? utilize;

  PreviewData({
    this.cumulativeFemaleMortPercentage,
    this.cumulativeUtilize,
    this.eggMass,
    this.eggWeight,
    this.femaleFeed,
    this.femaleWeight,
    this.hatchedEggPerHatchedHen,
    this.hatchedHenPercentage,
    this.hatchedPercentage,
    this.hatchedWeightPercentage,
    this.lightingProgram,
    this.maleFeed,
    this.maleWeight,
    this.totalEggPerHatchedHen,
    this.utilize,
  });

  factory PreviewData.fromJson(Map<String, dynamic> json) {
    return PreviewData(
      cumulativeFemaleMortPercentage:
          json['cumulative_female_mort_percentage'] == null
              ? null
              : MeasurementData.fromJson(
                  json['cumulative_female_mort_percentage']),
      cumulativeUtilize: json['cumulative_utilize'] == null
          ? null
          : MeasurementData.fromJson(json['cumulative_utilize']),
      eggMass: json['egg_mass'] == null
          ? null
          : MeasurementData.fromJson(json['egg_mass']),
      eggWeight: json['egg_weight'] == null
          ? null
          : MeasurementData.fromJson(json['egg_weight']),
      femaleFeed: json['female_feed'] == null
          ? null
          : MeasurementData.fromJson(json['female_feed']),
      femaleWeight: json['female_weight'] == null
          ? null
          : MeasurementData.fromJson(json['female_weight']),
      hatchedEggPerHatchedHen: json['hatched_egg_per_hatched_hen'] == null
          ? null
          : MeasurementData.fromJson(json['hatched_egg_per_hatched_hen']),
      hatchedHenPercentage: json['hatched_hen_percentage'] == null
          ? null
          : MeasurementData.fromJson(json['hatched_hen_percentage']),
      hatchedPercentage: json['hatched_percentage'] == null
          ? null
          : MeasurementData.fromJson(json['hatched_percentage']),
      hatchedWeightPercentage: json['hatched_weight_percentage'] == null
          ? null
          : MeasurementData.fromJson(json['hatched_weight_percentage']),
      lightingProgram: json['lighting_prog'] == null
          ? null
          : MeasurementData.fromJson(json['lighting_prog']),
      maleFeed: json['male_feed'] == null
          ? null
          : MeasurementData.fromJson(json['male_feed']),
      maleWeight: json['male_weight'] == null
          ? null
          : MeasurementData.fromJson(json['male_weight']),
      totalEggPerHatchedHen: json['total_egg_per_hatched_hen'] == null
          ? null
          : MeasurementData.fromJson(json['total_egg_per_hatched_hen']),
      utilize: json['utilize'] == null
          ? null
          : MeasurementData.fromJson(json['utilize']),
    );
  }
}
