import 'package:hive/hive.dart';

part 'week_data_value_params.g.dart'; // Ensure this file is generated

@HiveType(typeId: 25) // Unique ID for Hive
class Params extends HiveObject {
  @HiveField(0)
  int? femaleFeed;

  @HiveField(1)
  int? maleFeed;

  @HiveField(2)
  int? cycleFemale;

  @HiveField(3)
  int? cycleMale;

  @HiveField(4)
  int? femaleWeight;

  @HiveField(5)
  int? maleWeight;

  @HiveField(6)
  int? femaleMort;

  @HiveField(7)
  int? maleMort;

  @HiveField(8)
  int? sexErrors;

  @HiveField(9)
  int? culls;

  @HiveField(10)
  int? lightingProg;

  @HiveField(11)
  int? totalEgg;

  @HiveField(12)
  int? hatchedEgg;

  @HiveField(13)
  int? lastWeekCumulativeLoses;

  @HiveField(14)
  int? lastWeekCumulativeFemaleMort;

  @HiveField(15)
  int? lastWeekCumulativeMaleMort;

  @HiveField(16)
  int? lastWeekFemaleBalance;

  @HiveField(17)
  int? lastWeekMaleBalance;

  @HiveField(18)
  int? lastWeekCumulativeTotalEggs;

  @HiveField(19)
  int? lastWeekCumulativeHatchedEgg;

  @HiveField(20)
  int? loses;

  @HiveField(21)
  int? cumulativeLoses;

  @HiveField(22)
  int? cumulativeFemaleMort;

  @HiveField(23)
  int? cumulativeMaleMort;

  @HiveField(24)
  int? cumulativeTotalEggs;

  @HiveField(25)
  int? cumulativeHatchedEgg;

  @HiveField(26)
  int? femaleBalance;

  @HiveField(27)
  double? cumulativeFemaleMortPercentage;

  @HiveField(28)
  double? utilize;

  @HiveField(29)
  double? eggWeight;

  Params({
    this.femaleFeed,
    this.maleFeed,
    this.cycleFemale,
    this.cycleMale,
    this.femaleWeight,
    this.maleWeight,
    this.femaleMort,
    this.maleMort,
    this.sexErrors,
    this.culls,
    this.lightingProg,
    this.totalEgg,
    this.hatchedEgg,
    this.eggWeight,
    this.lastWeekCumulativeLoses,
    this.lastWeekCumulativeFemaleMort,
    this.lastWeekCumulativeMaleMort,
    this.lastWeekFemaleBalance,
    this.lastWeekMaleBalance,
    this.lastWeekCumulativeTotalEggs,
    this.lastWeekCumulativeHatchedEgg,
    this.loses,
    this.cumulativeLoses,
    this.cumulativeFemaleMort,
    this.cumulativeMaleMort,
    this.cumulativeTotalEggs,
    this.cumulativeHatchedEgg,
    this.femaleBalance,
    this.cumulativeFemaleMortPercentage,
    this.utilize,
  });

  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(
      femaleFeed: json['female_feed'],
      maleFeed: json['male_feed'],
      cycleFemale: json['cycle__female'],
      cycleMale: json['cycle__male'],
      femaleWeight: json['female_weight'],
      maleWeight: json['male_weight'],
      femaleMort: json['female_mort'],
      maleMort: json['male_mort'],
      sexErrors: json['sex_errors'],
      culls: json['culls'],
      lightingProg: json['lighting_prog'],
      totalEgg: json['total_egg'],
      hatchedEgg: json['hatched_egg'],
      eggWeight: (json['egg_weight'] as num?)?.toDouble(),
      lastWeekCumulativeLoses: json['last_week__cumulative_loses'],
      lastWeekCumulativeFemaleMort: json['last_week__cumulative_female_mort'],
      lastWeekCumulativeMaleMort: json['last_week__cumulative_male_mort'],
      lastWeekFemaleBalance: json['last_week__female_balance'],
      lastWeekMaleBalance: json['last_week__male_balance'],
      lastWeekCumulativeTotalEggs: json['last_week__cumulative_total_eggs'],
      lastWeekCumulativeHatchedEgg: json['last_week__cumulative_hatched_egg'],
      loses: json['loses'],
      cumulativeLoses: json['cumulative_loses'],
      cumulativeFemaleMort: json['cumulative_female_mort'],
      cumulativeMaleMort: json['cumulative_male_mort'],
      cumulativeTotalEggs: json['cumulative_total_eggs'],
      cumulativeHatchedEgg: json['cumulative_hatched_egg'],
      femaleBalance: json['female_balance'],
      cumulativeFemaleMortPercentage:
          (json["cumulative_female_mort_percentage"] as num?)?.toDouble(),
      utilize: (json["utilize"] as num?)?.toDouble(),
    );
  }
}
