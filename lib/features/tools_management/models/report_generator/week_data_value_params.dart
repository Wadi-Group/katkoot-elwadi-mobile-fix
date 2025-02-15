class Params {
  int? femaleFeed,
      maleFeed,
      cycleFemale,
      cycleMale,
      femaleWeight,
      maleWeight,
      femaleMort,
      maleMort,
      sexErrors,
      culls,
      lightingProg,
      totalEgg,
      hatchedEgg,
      lastWeekCumulativeLoses,
      lastWeekCumulativeFemaleMort,
      lastWeekCumulativeMaleMort,
      lastWeekFemaleBalance,
      lastWeekMaleBalance,
      lastWeekCumulativeTotalEggs,
      lastWeekCumulativeHatchedEgg,
      loses,
      cumulativeLoses,
      cumulativeFemaleMort,
      cumulativeMaleMort,
      cumulativeTotalEggs,
      cumulativeHatchedEgg,
      femaleBalance;
  double? cumulativeFemaleMortPercentage, utilize, eggWeight;

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
    this.cumulativeHatchedEgg,
    this.cumulativeTotalEggs,
    this.femaleBalance,
    this.cumulativeFemaleMortPercentage,
    this.utilize,
  });

  Params.fromJson(Map<String, dynamic> json) {
    femaleFeed = json['female_feed'];
    maleFeed = json['male_feed'];
    cycleFemale = json['cycle__female'];
    cycleMale = json['cycle__male'];
    femaleWeight = json['female_weight'];
    maleWeight = json['male_weight'];
    femaleMort = json['female_mort'];
    maleMort = json['male_mort'];
    sexErrors = json['sex_errors'];
    culls = json['culls'];
    lightingProg = json['lighting_prog'];
    totalEgg = json['total_egg'];
    hatchedEgg = json['hatched_egg'];
    eggWeight = json['egg_weight'].toDouble();
    lastWeekCumulativeLoses = json['last_week__cumulative_loses'];
    lastWeekCumulativeFemaleMort = json['last_week__cumulative_female_mort'];
    lastWeekCumulativeMaleMort = json['last_week__cumulative_male_mort'];
    lastWeekFemaleBalance = json['last_week__female_balance'];
    lastWeekMaleBalance = json['last_week__male_balance'];
    lastWeekCumulativeTotalEggs = json['last_week__cumulative_total_eggs'];
    lastWeekCumulativeHatchedEgg = json['last_week__cumulative_hatched_egg'];
    loses = json['loses'];
    cumulativeLoses = json['cumulative_loses'];
    cumulativeFemaleMort = json['cumulative_female_mort'];
    cumulativeMaleMort = json['cumulative_male_mort'];
    cumulativeHatchedEgg = json['cumulative_hatched_egg'];
    cumulativeTotalEggs = json['cumulative_total_eggs'];
    femaleBalance = json['female_balance'];
    cumulativeFemaleMortPercentage =
        (json["cumulative_female_mort_percentage"] is int)
            ? json["cumulative_female_mort_percentage"].toDouble()
            : json["cumulative_female_mort_percentage"];
    utilize =
        (json["utilize"] is int) ? json["utilize"].toDouble() : json["utilize"];
  }
}
