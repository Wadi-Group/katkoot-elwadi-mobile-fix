
class EquationsResultTitle {
  String? broilersPerYear;
  String? placedEggs;
  String? hatchingEggs;
  String? hen;
  String? broilersPerWeek;
  String? chickenPlacedBeforeDeath;
  String? pullets;

  EquationsResultTitle(
      {this.broilersPerYear,
        this.hen,
        this.chickenPlacedBeforeDeath,
        this.placedEggs,
        this.pullets,
        this.broilersPerWeek,
        this.hatchingEggs});

  EquationsResultTitle.fromJson(Map<String, dynamic> json) {
    broilersPerYear = json["broilers_per_year"];
    placedEggs = json["placed_eggs"];
    hatchingEggs = json["hatching_egg"];
    hen = json["hen"];
    chickenPlacedBeforeDeath = json["chicken_placed_before_death"];
    pullets = json["pullets"];
    broilersPerWeek = json["broilers_per_week"];
  }

}
