class Broiler {
  String? broilersPerYear;
  String? chickenPlacedBeforeDeath;
  String? placedEggs;
  String? hen;
  String? pullets;

  Broiler(
      {this.broilersPerYear,
      this.chickenPlacedBeforeDeath,
      this.hen,
      this.placedEggs,
      this.pullets});

  Broiler.fromJson(Map<String, dynamic> json) {
    broilersPerYear = json["broilers_per_year"];
    chickenPlacedBeforeDeath = json["chicken_placed_before_death"];
    placedEggs = json["placed_eggs"];
    hen = json["hen"];
    pullets = json["pullets"];
  }
}
