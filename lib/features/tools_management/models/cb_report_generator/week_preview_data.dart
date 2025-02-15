
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/cumulative_female_mort_percentage.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/cumulative_utilize.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/egg_mass.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/egg_weight.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/female_feed.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/female_weight.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/hatched_egg_per_hatched_hen.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/hatched_hen_percentage.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/hatched_percentage.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/hatched_weight_percentage.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/lighting_prog.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/male_feed.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/male_weight.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/total_egg_per_hatched_hen.dart';
import 'package:katkoot_elwady/features/tools_management/models/cb_report_generator/utilize.dart';


class PreviewData {
  CumulativeFemaleMortPercentage? cumulativeFemaleMortPercentage;
  CumulativeUtilize? cumulativeUtilize;
  EggMass? eggMass;
  EggWeight? eggWeight;
  FemaleFeed? femaleFeed;
  FemaleWeight? femaleWeight;
  HatchedEggPerHatchedHen? hatchedEggPerHatchedHen;
  HatchedHenPercentage? hatchedHenPercentage;
  HatchedPercentage? hatchedPercentage;
  HatchedWeightPercentage? hatchedWeightPercentage;
  LightingProgram? lightingProgram;
  MaleFeed? maleFeed;
  MaleWeight? maleWeight;
  TotalEggPerHatchedHen? totalEggPerHatchedHen;
  Utilize? utilize;

  PreviewData(
      {
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

  PreviewData.fromJson(Map<String, dynamic> json) {
    cumulativeFemaleMortPercentage = json['cumulative_female_mort_percentage'] == null ? null : CumulativeFemaleMortPercentage.fromJson(json['cumulative_female_mort_percentage']);
    cumulativeUtilize = json['cumulative_utilize'] == null ? null : CumulativeUtilize.fromJson(json['cumulative_utilize']);
    eggMass = json['egg_mass'] == null ? null : EggMass.fromJson(json['egg_mass']);
    eggWeight = json['egg_weight'] == null ? null : EggWeight.fromJson(json['egg_weight']);
    femaleFeed = json['female_feed'] == null ? null : FemaleFeed.fromJson(json['female_feed']);
    femaleWeight = json['female_weight'] == null ? null : FemaleWeight.fromJson(json['female_weight']);
    hatchedEggPerHatchedHen = json['hatched_egg_per_hatched_hen'] == null ? null : HatchedEggPerHatchedHen.fromJson(json['hatched_egg_per_hatched_hen']);
    hatchedHenPercentage = json['hatched_hen_percentage'] == null ? null : HatchedHenPercentage.fromJson(json['hatched_hen_percentage']);
    hatchedPercentage = json['hatched_percentage'] == null ? null : HatchedPercentage.fromJson(json['hatched_percentage']);
    hatchedWeightPercentage = json['hatched_weight_percentage'] == null ? null : HatchedWeightPercentage.fromJson(json['hatched_weight_percentage']);
    lightingProgram = json['lighting_prog'] == null ? null : LightingProgram.fromJson(json['lighting_prog']);
    maleFeed = json['male_feed'] == null ? null : MaleFeed.fromJson(json['male_feed']);
    maleWeight = json['male_weight'] == null ? null : MaleWeight.fromJson(json['male_weight']);
    totalEggPerHatchedHen = json['total_egg_per_hatched_hen'] == null ? null : TotalEggPerHatchedHen.fromJson(json['total_egg_per_hatched_hen']);
    utilize = json['utilize'] == null ? null : Utilize.fromJson(json['utilize']);
  }

}
